part of 'mylist_manga_bloc.dart';

abstract class MylistMangaState extends Equatable {
  const MylistMangaState();
}

class MylistMangaStateAction extends MylistMangaState {
  const MylistMangaStateAction();

  @override
  List<Object> get props => [];
}

class MylistMangaInitial extends MylistMangaState {
  @override
  List<Object> get props => [];
}

class MylistMangaLoad extends MylistMangaState {
  final List<MylistModel> mangaList;

  const MylistMangaLoad({required this.mangaList});

  @override
  List<Object> get props => [mangaList];
}

class MylistMangaLoading extends MylistMangaStateAction {
  const MylistMangaLoading();

  @override
  List<Object> get props => [];
}
