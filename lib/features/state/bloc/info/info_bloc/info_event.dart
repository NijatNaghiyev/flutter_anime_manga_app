part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class InfoAnimeEvent extends InfoEvent {
  final int malId;
  const InfoAnimeEvent({required this.malId});

  @override
  List<Object> get props => [malId];
}

class InfoMangaEvent extends InfoEvent {
  final int malId;
  const InfoMangaEvent({required this.malId});

  @override
  List<Object> get props => [malId];
}
