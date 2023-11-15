part of 'season_last_bloc.dart';

abstract class SeasonLastState extends Equatable {
  const SeasonLastState();
}

class SeasonLastAction extends SeasonLastState {
  @override
  List<Object> get props => [];
}

class SeasonLastInitial extends SeasonLastState {
  @override
  List<Object> get props => [];
}

class SeasonLastLoading extends SeasonLastAction {
  @override
  List<Object> get props => [];
}

class SeasonLastLoaded extends SeasonLastState {
  final List<SeasonalData> seasonalData;
  final List<MylistModel> animeList;

  const SeasonLastLoaded({required this.seasonalData, required this.animeList});

  @override
  List<Object?> get props => [seasonalData];
}

class SeasonLastError extends SeasonLastState {
  final String message;
  const SeasonLastError({required this.message});

  @override
  List<Object?> get props => [message];
}
