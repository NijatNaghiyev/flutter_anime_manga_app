import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/enum/parameter_search_type.dart';
import '../../../../../data/models/mylist/mylist_model.dart';
import '../../../../../data/models/seasonal/seasonal_model.dart';
import '../../../../../data/models/seasonal/seasons_model.dart';
import '../../../../../data/services/firestore_database/mylist_anime_store.dart';
import '../../../../../data/services/seasonal/season_any.dart';
import '../../../../../data/services/seasonal/seasons.dart';

part 'season_archive_event.dart';
part 'season_archive_state.dart';

class SeasonArchiveBloc extends Bloc<SeasonArchiveEvent, SeasonArchiveState> {
  final SeasonArchiveService seasonArchiveService;
  final SeasonsService seasonsService;
  List<SeasonalData> seasonalData = [];
  int page = 1;
  SeasonArchiveBloc(
      {required this.seasonsService, required this.seasonArchiveService})
      : super(SeasonArchiveInitial()) {
    on<SeasonArchiveInitialEvent>(seasonArchiveInitialEvent);
    on<SeasonArchiveInitPageEvent>(seasonArchiveInitPageEvent);
  }

  Future<FutureOr<void>> seasonArchiveInitialEvent(
      SeasonArchiveInitialEvent event, Emitter<SeasonArchiveState> emit) async {
    emit(SeasonArchiveLoading());

    final data = await seasonArchiveService.getSeasonArchive(
        year: event.year,
        season: event.season,
        page: page,
        paraType: event.type);

    if (data.data.isNotEmpty) {
      seasonalData.addAll(data.data);

      /// If there is a next page, then the page number will be incremented by 1
      if (data.pagination.hasNextPage) {
        page++;
      }

      final animeList = await MylistAnimeStore.getMylist();

      emit(SeasonArchiveLoaded(
          seasonalData: seasonalData, animeList: animeList));
    } else {
      emit(const SeasonArchiveError(message: 'No Data'));
    }
  }

  Future<FutureOr<void>> seasonArchiveInitPageEvent(
      SeasonArchiveInitPageEvent event,
      Emitter<SeasonArchiveState> emit) async {
    emit(SeasonArchiveLoading());

    final data = await seasonsService.getSeasons();

    if (data.isNotEmpty) {
      emit(SeasonArchiveInitPageState(seasonsData: data));
    } else {
      emit(const SeasonArchiveError(message: 'No Data'));
    }
  }
}
