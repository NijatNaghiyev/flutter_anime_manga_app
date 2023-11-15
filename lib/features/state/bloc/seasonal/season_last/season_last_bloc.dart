import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/enum/parameter_search_type.dart';
import '../../../../../data/models/mylist/mylist_model.dart';
import '../../../../../data/models/seasonal/seasonal_model.dart';
import '../../../../../data/services/firestore_database/mylist_anime_store.dart';
import '../../../../../data/services/seasonal/season_last.dart';

part 'season_last_event.dart';
part 'season_last_state.dart';

class SeasonLastBloc extends Bloc<SeasonLastEvent, SeasonLastState> {
  final SeasonLastService seasonLastService;
  List<SeasonalData> seasonalData = [];
  int page = 1;
  SeasonLastBloc({required this.seasonLastService})
      : super(SeasonLastInitial()) {
    on<SeasonLastInitialEvent>(seasonLastInitialEvent);
  }

  Future<FutureOr<void>> seasonLastInitialEvent(
      SeasonLastInitialEvent event, Emitter<SeasonLastState> emit) async {
    emit(SeasonLastLoading());

    final data =
        await seasonLastService.getSeasonLast(page: page, paraType: event.type);

    if (data.data.isNotEmpty) {
      seasonalData.addAll(data.data);

      /// If there is a next page, then the page number will be incremented by 1
      if (data.pagination.hasNextPage) {
        page++;
      }

      final animeList = await MylistAnimeStore.getMylist();

      emit(SeasonLastLoaded(seasonalData: seasonalData, animeList: animeList));
    } else {
      emit(const SeasonLastError(message: 'No Data'));
    }
  }
}
