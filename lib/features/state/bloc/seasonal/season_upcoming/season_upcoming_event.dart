part of 'season_upcoming_bloc.dart';

abstract class SeasonUpcomingEvent extends Equatable {
  const SeasonUpcomingEvent();
}

class SeasonUpcomingInitialEvent extends SeasonUpcomingEvent {
  final ParameterSearchTypeAnime type;

  const SeasonUpcomingInitialEvent({required this.type});

  @override
  List<Object?> get props => [type];
}
