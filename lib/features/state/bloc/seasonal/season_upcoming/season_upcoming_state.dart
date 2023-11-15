part of 'season_upcoming_bloc.dart';

abstract class SeasonUpcomingState extends Equatable {
  const SeasonUpcomingState();
}

class SeasonUpcomingAction extends SeasonUpcomingState {
  @override
  List<Object> get props => [];
}

class SeasonUpcomingInitial extends SeasonUpcomingState {
  @override
  List<Object> get props => [];
}

class SeasonUpcomingLoading extends SeasonUpcomingAction {
  @override
  List<Object> get props => [];
}

class SeasonUpcomingLoaded extends SeasonUpcomingState {
  final List<SeasonalData> seasonalData;

  final List<MylistModel> animeList;

  const SeasonUpcomingLoaded(
      {required this.seasonalData, required this.animeList});

  @override
  List<Object?> get props => [seasonalData];
}

class SeasonUpcomingError extends SeasonUpcomingState {
  final String message;
  const SeasonUpcomingError({required this.message});

  @override
  List<Object?> get props => [message];
}
