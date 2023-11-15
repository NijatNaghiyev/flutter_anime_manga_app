import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../data/models/top_data/top_characters_model.dart';
import '../../../../../../data/services/top_data/top_characters_service.dart';

part 'top_characters_event.dart';
part 'top_characters_state.dart';

class TopCharactersBloc extends Bloc<TopCharactersEvent, TopCharactersState> {
  final TopCharactersService topCharactersService;
  TopCharactersBloc(this.topCharactersService) : super(TopCharactersInitial()) {
    on<TopCharactersLoadEvent>(topCharactersLoadEvent);
  }

  Future<FutureOr<void>> topCharactersLoadEvent(
      TopCharactersLoadEvent event, Emitter<TopCharactersState> emit) async {
    emit(TopCharactersInitial());

    final topCharactersModel = await topCharactersService.getTopCharacters();
    if (topCharactersModel != null) {
      emit(TopCharactersLoadState(topCharactersModel: topCharactersModel));
    } else {
      emit(const TopCharactersErrorState(message: 'Something went wrong'));
    }
  }
}
