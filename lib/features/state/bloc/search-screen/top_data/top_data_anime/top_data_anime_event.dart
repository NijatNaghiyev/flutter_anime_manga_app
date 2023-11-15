part of 'top_data_anime_bloc.dart';

abstract class TopDataAnimeEvent extends Equatable {
  const TopDataAnimeEvent();
}

class TopDataAnimeLoadEvent extends TopDataAnimeEvent {
  const TopDataAnimeLoadEvent();
  @override
  List<Object?> get props => [];
}
