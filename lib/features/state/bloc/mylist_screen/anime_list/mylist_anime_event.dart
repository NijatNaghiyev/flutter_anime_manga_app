part of 'mylist_anime_bloc.dart';

abstract class MylistAnimeEvent extends Equatable {
  const MylistAnimeEvent();
}

class MylistAnimeInitialEvent extends MylistAnimeEvent {
  const MylistAnimeInitialEvent();

  @override
  List<Object> get props => [];
}

class MylistAnimeLoadEvent extends MylistAnimeEvent {
  const MylistAnimeLoadEvent();

  @override
  List<Object> get props => [];
}

class MylistAnimeAddEvent extends MylistAnimeEvent {
  const MylistAnimeAddEvent({
    required this.mylistModel,
  });

  final MylistModel mylistModel;

  @override
  List<Object> get props => [mylistModel];
}
