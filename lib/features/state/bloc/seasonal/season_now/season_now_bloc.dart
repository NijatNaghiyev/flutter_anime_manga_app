import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_anime_manga_app/data/models/seasonal/seasonal_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/enum/parameter_search_type.dart';
import '../../../../../data/models/mylist/mylist_model.dart';
import '../../../../../data/services/firestore_database/mylist_anime_store.dart';
import '../../../../../data/services/seasonal/season_now.dart';

part 'season_now_event.dart';
part 'season_now_state.dart';

class SeasonNowBloc extends Bloc<SeasonNowEvent, SeasonNowState> {
  final SeasonNowService seasonNowService;
  List<SeasonalData> seasonalData = [];
  int page = 1;
  SeasonNowBloc({required this.seasonNowService}) : super(SeasonNowInitial()) {
    on<SeasonNowInitialEvent>(seasonNowInitialEvent);
  }

  Future<FutureOr<void>> seasonNowInitialEvent(
      SeasonNowInitialEvent event, Emitter<SeasonNowState> emit) async {
    emit(SeasonNowLoading());

    final data =
        await seasonNowService.getSeasonNow(page: page, paraType: event.type);

    if (data.data.isNotEmpty) {
      seasonalData.addAll(data.data);

      /// If there is a next page, then the page number will be incremented by 1
      if (data.pagination.hasNextPage) {
        page++;
      }

      final animeList = await MylistAnimeStore.getMylist();

      emit(SeasonNowLoaded(seasonalData: seasonalData, animeList: animeList));
    } else {
      emit(const SeasonNowError(message: 'No Data'));
    }
  }
}
