import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_anime_manga_app/data/services/top_data/top_people_service.dart';

import '../../../../../../data/models/top_data/top_people_model.dart';

part 'top_people_event.dart';
part 'top_people_state.dart';

class TopPeopleBloc extends Bloc<TopPeopleEvent, TopPeopleState> {
  final TopPeopleService topPeople;
  TopPeopleBloc(this.topPeople) : super(TopPeopleInitial()) {
    on<TopPeopleLoadEvent>(topPeopleLoadEvent);
  }

  Future<FutureOr<void>> topPeopleLoadEvent(
      TopPeopleLoadEvent event, Emitter<TopPeopleState> emit) async {
    emit(TopPeopleInitial());

    final topPeopleData = await topPeople.getTopPeople();
    if (topPeopleData != null) {
      emit(TopPeopleLoadState(topPeopleModel: topPeopleData));
    } else {
      emit(const TopPeopleErrorState(message: 'Something went wrong'));
    }
  }
}
