part of 'season_last_bloc.dart';

abstract class SeasonLastEvent extends Equatable {
  const SeasonLastEvent();
}

class SeasonLastInitialEvent extends SeasonLastEvent {
  final ParameterSearchTypeAnime type;

  const SeasonLastInitialEvent({required this.type});

  @override
  List<Object?> get props => [type];
}
