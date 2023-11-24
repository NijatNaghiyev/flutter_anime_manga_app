import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/data/services/firestore_database/favorite_anime_firebase.dart';
import 'package:flutter_anime_manga_app/data/services/firestore_database/favorite_manga_firebase.dart';

import '../../../../data/models/info/favorite_model.dart';
import 'profile_favorite_card.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ValueNotifier<List<FavoriteModel>> favoriteAnimeList = ValueNotifier([]);
  ValueNotifier<List<FavoriteModel>> favoriteMangaList = ValueNotifier([]);
  ValueNotifier<int> tabIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      tabIndex.value = _tabController.index;
    });
    FavoriteAnimeFirebaseService.getFavoriteAnimeList().then((value) {
      favoriteAnimeList.value = value;
    });
    FavoriteMangaFirebaseService.getFavoriteMangaList().then((value) {
      favoriteMangaList.value = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const Divider(),
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Anime',
              ),
              Tab(
                text: 'Manga',
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: tabIndex,
            builder: (context, value, _) {
              if (value == 0) {
                return ValueListenableBuilder(
                  valueListenable: favoriteAnimeList,
                  builder: (context, value, _) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.length,
                      itemBuilder: (context, index) =>
                          ProfileFavoriteCard(value: value[index]),
                    );
                  },
                );
              }
              if (value == 1) {
                return ValueListenableBuilder(
                  valueListenable: favoriteMangaList,
                  builder: (context, value, _) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.length,
                      itemBuilder: (context, index) => ProfileFavoriteCard(
                        value: value[index],
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
