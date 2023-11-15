part of 'mylist_anime_bloc.dart';

abstract class MylistAnimeState extends Equatable {
  const MylistAnimeState();
}

class MylistAnimeStateAction extends MylistAnimeState {
  const MylistAnimeStateAction();

  @override
  List<Object> get props => [];
}

class MylistAnimeInitial extends MylistAnimeState {
  @override
  List<Object> get props => [];
}

class MylistAnimeLoad extends MylistAnimeState {
  final List<MylistModel> animeList;

  const MylistAnimeLoad({required this.animeList});

  @override
  List<Object> get props => [animeList];
}

class MylistAnimeLoading extends MylistAnimeStateAction {
  const MylistAnimeLoading();

  @override
  List<Object> get props => [];
}
