import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_anime_manga_app/data/models/info/themes_model.dart';

import '../../../../../data/models/anime/anime_full_model.dart';
import '../../../../../data/models/info/anime_staff_model.dart';
import '../../../../../data/models/info/music_videos_model.dart';
import '../../../../../data/models/info/review_model.dart';
import '../../../../../data/models/manga/manga_full_model.dart';
import '../../../../../data/services/info/anime_full.dart';
import '../../../../../data/services/info/anime_images.dart';
import '../../../../../data/services/info/anime_staff.dart';
import '../../../../../data/services/info/manga_full.dart';
import '../../../../../data/services/info/manga_images.dart';
import '../../../../../data/services/info/themes_service.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final AnimeFullService animeFullService;
  final MangaFullService mangaFullService;
  List<String> imagesList = [];

  InfoBloc({required this.animeFullService, required this.mangaFullService})
      : super(InfoInitial()) {
    on<InfoAnimeEvent>(infoAnimeEvent);
    on<InfoMangaEvent>(infoMangaEvent);
  }

  //! Anime Event
  Future<FutureOr<void>> infoAnimeEvent(
      InfoAnimeEvent event, Emitter<InfoState> emit) async {
    emit(InfoLoadingState());

    final data = await animeFullService.getAnimeFull(malId: event.malId);

    if (data != null) {
      imagesList = [];

      await Future.delayed(const Duration(milliseconds: 800));

      /// Get images
      final getImages =
          await AnimeImagesService.getAnimeImages(malId: event.malId);
      imagesList.addAll([
        ...[data.data!.images!['jpg']!.imageUrl!],
        ...getImages,
      ]);

      await Future.delayed(const Duration(milliseconds: 1000));

      /// Anime Staff
      final animeStaff =
          await AnimeStaffService.getAnimeStaff(malId: event.malId);

      /// Themes
      final themes = await ThemesService.getThemes(malId: event.malId);

      emit(
        InfoAnimeLoadedState(
          animeFull: data,
          imagesList: imagesList,
          animeStaff: animeStaff,
          themesModel: themes,
          musicVideos: const [],
          reviews: const [],
        ),
      );
    } else {
      emit(const InfoErrorState(message: 'Something went wrong'));
    }
  }

//?////////////////////////////////////////////////////////////////////////////////////////////////////
  //! Manga Event
  Future<FutureOr<void>> infoMangaEvent(
      InfoMangaEvent event, Emitter<InfoState> emit) async {
    emit(InfoLoadingState());

    /// Manga Full
    final data = await mangaFullService.getMangaFull(malId: event.malId);

    if (data != null) {
      imagesList = [];

      await Future.delayed(const Duration(milliseconds: 800));

      /// Get images
      final getImages =
          await MangaImagesService.getMangaImages(malId: event.malId);
      imagesList.addAll([
        ...[data.data!.images!['jpg']!.imageUrl!],
        ...getImages,
      ]);

      await Future.delayed(const Duration(milliseconds: 600));

      emit(
        InfoMangaLoadedState(
          mangaFull: data,
          imagesList: imagesList,
          reviews: const [],
        ),
      );
    } else {
      emit(const InfoErrorState(message: 'Something went wrong'));
    }
  }
}
