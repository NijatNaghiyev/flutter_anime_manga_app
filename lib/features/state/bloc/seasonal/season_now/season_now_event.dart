part of 'season_now_bloc.dart';

abstract class SeasonNowEvent extends Equatable {
  const SeasonNowEvent();
}

class SeasonNowInitialEvent extends SeasonNowEvent {
  final ParameterSearchTypeAnime type;

  const SeasonNowInitialEvent({required this.type});

  @override
  List<Object?> get props => [type];
}
