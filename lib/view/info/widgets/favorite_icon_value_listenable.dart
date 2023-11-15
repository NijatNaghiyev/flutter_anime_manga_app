import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/data/services/firestore_database/favorite_manga_firebase.dart';

import '../../../constants/enum/search_type.dart';
import '../../../data/models/info/favorite_model.dart';
import '../../../data/services/firestore_database/favorite_anime_firebase.dart';

ValueNotifier<Map<String, List<FavoriteModel>>>
    favoriteAnimeMangaListValueNotifier = ValueNotifier({
  'anime': <FavoriteModel>[],
  'manga': <FavoriteModel>[],
});

class FavoriteIconValueListenable extends StatefulWidget {
  const FavoriteIconValueListenable({
    super.key,
    required this.data,
    required this.searchType,
  });

  final data;
  final SearchType searchType;

  @override
  State<FavoriteIconValueListenable> createState() =>
      _FavoriteIconValueListenableState();
}

class _FavoriteIconValueListenableState
    extends State<FavoriteIconValueListenable> {
  bool isFavorite(Map mapList) {
    if (widget.searchType == SearchType.anime) {
      return mapList['anime']!
          .any((element) => element.malId == widget.data.malId);
    } else {
      return mapList['manga']!
          .any((element) => element.malId == widget.data.malId);
    }
  }

  void initFavorite() {
    if (widget.searchType == SearchType.anime) {
      FavoriteAnimeFirebaseService.getFavoriteAnimeList()
          .then((value) => favoriteAnimeMangaListValueNotifier.value = {
                'anime': value,
                'manga': favoriteAnimeMangaListValueNotifier.value['manga']!,
              });
    } else {
      FavoriteMangaFirebaseService.getFavoriteMangaList()
          .then((value) => favoriteAnimeMangaListValueNotifier.value = {
                'anime': favoriteAnimeMangaListValueNotifier.value['anime']!,
                'manga': value,
              });
    }
  }

  @override
  void initState() {
    super.initState();
    initFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, List<FavoriteModel>>>(
        valueListenable: favoriteAnimeMangaListValueNotifier,
        builder: (context, value, _) {
          isFavorite(value);
          return IconButton(
            onPressed: () async {
              if (widget.searchType == SearchType.anime) {
                await FavoriteAnimeFirebaseService.addOrRemoveFavorite(
                  favoriteModel: FavoriteModel(
                    malId: widget.data.malId!,
                    title: widget.data.title!,
                    imageUrl: widget.data.images!['jpg']!.imageUrl!,
                    type: SearchType.anime.name,
                    airingStart: widget.data.aired!.string ?? 'N/A',
                  ),
                );
              } else if (widget.searchType == SearchType.manga) {
                await FavoriteMangaFirebaseService.addOrRemoveFavorite(
                  favoriteModel: FavoriteModel(
                    malId: widget.data.malId!,
                    title: widget.data.title!,
                    imageUrl: widget.data.images!['jpg']!.imageUrl!,
                    type: SearchType.manga.name,
                    airingStart: widget.data.published!.string ?? 'N/A',
                  ),
                );
              }
            },
            icon: isFavorite(value)
                ? const Icon(
                    Icons.favorite_outlined,
                    color: Colors.red,
                  )
                : const Icon(Icons.favorite_border_outlined),
          );
        });
  }
}
