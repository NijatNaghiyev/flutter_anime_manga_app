part of 'season_now_bloc.dart';

abstract class SeasonNowState extends Equatable {
  const SeasonNowState();
}

class SeasonNowAction extends SeasonNowState {
  @override
  List<Object> get props => [];
}

class SeasonNowInitial extends SeasonNowState {
  @override
  List<Object> get props => [];
}

class SeasonNowLoading extends SeasonNowAction {
  @override
  List<Object> get props => [];
}

class SeasonNowLoaded extends SeasonNowState {
  final List<SeasonalData> seasonalData;
  final List<MylistModel> animeList;
  const SeasonNowLoaded({required this.seasonalData, required this.animeList});

  @override
  List<Object?> get props => [seasonalData];
}

class SeasonNowError extends SeasonNowState {
  final String message;
  const SeasonNowError({required this.message});

  @override
  List<Object?> get props => [message];
}
