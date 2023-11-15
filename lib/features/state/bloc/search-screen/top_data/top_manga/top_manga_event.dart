part of 'top_manga_bloc.dart';

abstract class TopMangaEvent extends Equatable {
  const TopMangaEvent();
}

class TopMangaLoadEvent extends TopMangaEvent {
  const TopMangaLoadEvent();
  @override
  List<Object?> get props => [];
}
