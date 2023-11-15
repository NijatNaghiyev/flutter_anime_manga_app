part of 'top_data_anime_bloc.dart';

abstract class TopDataAnimeState extends Equatable {
  const TopDataAnimeState();
}

class TopDataAnimeInitial extends TopDataAnimeState {
  @override
  List<Object> get props => [];
}

class TopDataAnimeLoadState extends TopDataAnimeState {
  final List<Datum> topAnimeModel;

  const TopDataAnimeLoadState({required this.topAnimeModel});

  @override
  List<Object> get props => [topAnimeModel];
}

class TopDataAnimeErrorState extends TopDataAnimeState {
  final String message;

  const TopDataAnimeErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
