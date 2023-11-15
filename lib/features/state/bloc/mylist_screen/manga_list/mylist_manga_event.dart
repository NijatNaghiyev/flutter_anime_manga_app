part of 'mylist_manga_bloc.dart';

abstract class MylistMangaEvent extends Equatable {
  const MylistMangaEvent();
}

class MylistMangaInitialEvent extends MylistMangaEvent {
  const MylistMangaInitialEvent();

  @override
  List<Object> get props => [];
}

class MylistMangaLoadEvent extends MylistMangaEvent {
  const MylistMangaLoadEvent();

  @override
  List<Object> get props => [];
}

class MylistMangaAddEvent extends MylistMangaEvent {
  const MylistMangaAddEvent({
    required this.mylistModel,
  });

  final MylistModel mylistModel;

  @override
  List<Object> get props => [mylistModel];
}
