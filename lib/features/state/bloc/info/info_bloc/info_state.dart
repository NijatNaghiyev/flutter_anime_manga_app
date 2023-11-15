part of 'info_bloc.dart';

abstract class InfoState extends Equatable {
  const InfoState();
}

class InfoStateAction extends InfoState {
  @override
  List<Object> get props => [];
}

class InfoInitial extends InfoState {
  @override
  List<Object> get props => [];
}

class InfoLoadingState extends InfoStateAction {
  @override
  List<Object> get props => [];
}

class InfoAnimeLoadedState extends InfoState {
  final AnimeFullModel animeFull;
  final List<String> imagesList;
  final List<AnimeStaffModel> animeStaff;
  final ThemesModel? themesModel;
  final List<MusicVideosModel> musicVideos;
  final List<ReviewModel> reviews;

  const InfoAnimeLoadedState({
    required this.reviews,
    required this.musicVideos,
    required this.themesModel,
    required this.animeStaff,
    required this.imagesList,
    required this.animeFull,
  });

  @override
  List<Object> get props => [animeFull, imagesList, animeStaff, musicVideos];
}

class InfoMangaLoadedState extends InfoState {
  final MangaFullModel mangaFull;
  final List<String> imagesList;
  final List<ReviewModel> reviews;

  const InfoMangaLoadedState({
    required this.reviews,
    required this.imagesList,
    required this.mangaFull,
  });

  @override
  List<Object> get props => [mangaFull, imagesList];
}

class InfoErrorState extends InfoState {
  final String message;
  const InfoErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
