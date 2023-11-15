import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/edit_list_bottom_sheet/status_anime.dart';
import '../../../../../data/models/mylist/mylist_model.dart';
import '../../../../../data/services/firestore_database/mylist_anime_store.dart';

part 'mylist_anime_event.dart';
part 'mylist_anime_state.dart';

class MylistAnimeBloc extends Bloc<MylistAnimeEvent, MylistAnimeState> {
  MylistAnimeBloc() : super(MylistAnimeInitial()) {
    on<MylistAnimeLoadEvent>(mylistAnimeLoadEvent);
    on<MylistAnimeAddEvent>(mylistAnimeAddEvent);
  }

  Future<FutureOr<void>> mylistAnimeLoadEvent(
      MylistAnimeLoadEvent event, Emitter<MylistAnimeState> emit) async {
    List<MylistModel> animeList = [];
    emit(const MylistAnimeLoading());
    animeList = await MylistAnimeStore.getMylist();

    emit(
      MylistAnimeLoad(
        animeList: animeList.cast<MylistModel>().reversed.toList(),
      ),
    );
  }

  Future<FutureOr<void>> mylistAnimeAddEvent(
      MylistAnimeAddEvent event, Emitter<MylistAnimeState> emit) async {
    List<MylistModel> animeList = [];
    emit(const MylistAnimeLoading());

    animeList = await MylistAnimeStore.getMylist();

    if (event.mylistModel.userProgress + 1 ==
        event.mylistModel.episodesOrChapters) {
      await MylistAnimeStore.saveMylist(
        mylistModel: event.mylistModel.copyWith(
            userProgress: event.mylistModel.userProgress + 1,
            userStatus: StatusAnime.completed),
      );
    } else {
      await MylistAnimeStore.saveMylist(
        mylistModel: event.mylistModel
            .copyWith(userProgress: event.mylistModel.userProgress + 1),
      );
    }

    for (var element in animeList) {
      if (element.malId == event.mylistModel.malId) {
        animeList.replaceRange(
          animeList.indexOf(element),
          animeList.indexOf(element) + 1,
          [
            event.mylistModel.copyWith(
              userProgress: event.mylistModel.userProgress + 1,
            ),
          ],
        );
      }
    }

    emit(
      MylistAnimeLoad(
        animeList: animeList.cast<MylistModel>().reversed.toList(),
      ),
    );
  }
}
