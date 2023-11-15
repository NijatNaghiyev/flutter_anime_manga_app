import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_anime_manga_app/data/services/top_data/top_manga_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/top_data/top_manga_model.dart';

part 'top_manga_event.dart';
part 'top_manga_state.dart';

class TopMangaBloc extends Bloc<TopMangaEvent, TopMangaState> {
  final TopMangaService topManga;
  TopMangaBloc(this.topManga) : super(TopMangaInitial()) {
    on<TopMangaLoadEvent>(topMangaLoadEvent);
  }

  Future<FutureOr<void>> topMangaLoadEvent(
      TopMangaLoadEvent event, Emitter<TopMangaState> emit) async {
    emit(TopMangaInitial());

    await Future.delayed(const Duration(milliseconds: 200));

    final topMangaData = await topManga.getTopManga();
    if (topMangaData != null) {
      emit(
        TopMangaLoadState(topMangaModel: topMangaData),
      );
    } else {
      emit(const TopMangaErrorState(message: 'Something went wrong'));
    }
  }
}
