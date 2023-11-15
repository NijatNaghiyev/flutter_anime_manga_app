import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/enum/parameter_search_type.dart';
import '../../../../../data/models/mylist/mylist_model.dart';
import '../../../../../data/models/seasonal/seasonal_model.dart';
import '../../../../../data/services/firestore_database/mylist_anime_store.dart';
import '../../../../../data/services/seasonal/season_upcoming.dart';

part 'season_upcoming_event.dart';
part 'season_upcoming_state.dart';

class SeasonUpcomingBloc
    extends Bloc<SeasonUpcomingEvent, SeasonUpcomingState> {
  final SeasonUpcomingService seasonUpcomingService;
  List<SeasonalData> seasonalData = [];
  int page = 1;
  SeasonUpcomingBloc({required this.seasonUpcomingService})
      : super(SeasonUpcomingInitial()) {
    on<SeasonUpcomingInitialEvent>(seasonUpcomingInitialEvent);
  }

  Future<FutureOr<void>> seasonUpcomingInitialEvent(
      SeasonUpcomingInitialEvent event,
      Emitter<SeasonUpcomingState> emit) async {
    emit(SeasonUpcomingLoading());

    final data = await seasonUpcomingService.getSeasonUpcoming(
        page: page, paraType: event.type);

    if (data.data.isNotEmpty) {
      seasonalData.addAll(data.data);

      /// If there is a next page, then the page number will be incremented by 1
      if (data.pagination.hasNextPage) {
        page++;
      }

      final animeList=await MylistAnimeStore.getMylist();


      emit(SeasonUpcomingLoaded(seasonalData: seasonalData, animeList: animeList));
    } else {
      emit(const SeasonUpcomingError(message: 'No Data'));
    }
  }
}
