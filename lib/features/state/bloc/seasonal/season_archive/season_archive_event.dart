part of 'season_archive_bloc.dart';

abstract class SeasonArchiveEvent extends Equatable {
  const SeasonArchiveEvent();
}

class SeasonArchiveInitialEvent extends SeasonArchiveEvent {
  final int year;
  final String season;
  final ParameterSearchTypeAnime type;

  const SeasonArchiveInitialEvent(
      {required this.year, required this.season, required this.type});

  @override
  List<Object?> get props => [type, year, season];
}

class SeasonArchiveInitPageEvent extends SeasonArchiveEvent {
  const SeasonArchiveInitPageEvent();

  @override
  List<Object?> get props => [];
}
