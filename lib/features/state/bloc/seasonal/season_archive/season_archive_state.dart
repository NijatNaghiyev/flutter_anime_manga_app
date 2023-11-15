part of 'season_archive_bloc.dart';

abstract class SeasonArchiveState extends Equatable {
  const SeasonArchiveState();
}

class SeasonArchiveAction extends SeasonArchiveState {
  @override
  List<Object> get props => [];
}

class SeasonArchiveInitial extends SeasonArchiveState {
  @override
  List<Object> get props => [];
}

class SeasonArchiveLoading extends SeasonArchiveAction {
  @override
  List<Object> get props => [];
}

class SeasonArchiveLoaded extends SeasonArchiveState {
  final List<SeasonalData> seasonalData;
  final List<MylistModel> animeList;

  const SeasonArchiveLoaded({required this.seasonalData, required this.animeList});

  @override
  List<Object?> get props => [seasonalData];
}

class SeasonArchiveError extends SeasonArchiveState {
  final String message;
  const SeasonArchiveError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SeasonArchiveInitPageState extends SeasonArchiveState {
  final List<SeasonsModel> seasonsData;

  const SeasonArchiveInitPageState({required this.seasonsData});

  @override
  List<Object> get props => [seasonsData];
}
