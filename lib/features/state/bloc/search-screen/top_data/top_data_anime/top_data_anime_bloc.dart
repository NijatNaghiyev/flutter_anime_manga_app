import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/top_data/top_anime_model.dart';
import '../../../../../../data/services/top_data/top_anime_service.dart';

part 'top_data_anime_event.dart';
part 'top_data_anime_state.dart';

class TopDataAnimeBloc extends Bloc<TopDataAnimeEvent, TopDataAnimeState> {
  final TopAnimeService topAnime;
  List<Datum> topAnimeDataList = [];
  int page = 1;

  TopDataAnimeBloc({required this.topAnime}) : super(TopDataAnimeInitial()) {
    on<TopDataAnimeLoadEvent>(topDataLoadEvent);
  }

  Future<FutureOr<void>> topDataLoadEvent(
      TopDataAnimeLoadEvent event, Emitter<TopDataAnimeState> emit) async {
    emit(TopDataAnimeInitial());

    final topAnimeData = await topAnime.getTopAnime(page: page);
    if (topAnimeData != null) {
      if (topAnimeData.pagination.hasNextPage) {
        page++;
      }

      topAnimeDataList.addAll(topAnimeData.data);
      emit(
        TopDataAnimeLoadState(topAnimeModel: topAnimeDataList),
      );
    } else {
      emit(const TopDataAnimeErrorState(message: 'Something went wrong'));
    }
  }
}
