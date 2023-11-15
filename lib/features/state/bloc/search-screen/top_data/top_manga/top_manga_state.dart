part of 'top_manga_bloc.dart';

abstract class TopMangaState extends Equatable {
  const TopMangaState();
}

class TopMangaInitial extends TopMangaState {
  @override
  List<Object> get props => [];
}

class TopMangaLoadState extends TopMangaState {
  final TopMangaModel topMangaModel;

  const TopMangaLoadState({required this.topMangaModel});

  @override
  List<Object> get props => [topMangaModel];
}

class TopMangaErrorState extends TopMangaState {
  final String message;

  const TopMangaErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
