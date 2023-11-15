import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_anime_manga_app/constants/edit_list_bottom_sheet/status_manga.dart';

import '../../../../../data/models/mylist/mylist_model.dart';
import '../../../../../data/services/firestore_database/mylist_manga_store.dart';

part 'mylist_manga_event.dart';
part 'mylist_manga_state.dart';

class MylistMangaBloc extends Bloc<MylistMangaEvent, MylistMangaState> {
  MylistMangaBloc() : super(MylistMangaInitial()) {
    on<MylistMangaLoadEvent>(mylistMangaLoadEvent);
    on<MylistMangaAddEvent>(mylistMangaAddEvent);
  }

  Future<FutureOr<void>> mylistMangaLoadEvent(
      MylistMangaLoadEvent event, Emitter<MylistMangaState> emit) async {
    List<MylistModel> mangaList = [];
    emit(const MylistMangaLoading());
    mangaList = await MylistMangaStore.getMylist();

    emit(
      MylistMangaLoad(
        mangaList: mangaList.cast<MylistModel>().reversed.toList(),
      ),
    );
  }

  Future<FutureOr<void>> mylistMangaAddEvent(
      MylistMangaAddEvent event, Emitter<MylistMangaState> emit) async {
    List<MylistModel> mangaList = [];
    emit(const MylistMangaLoading());

    mangaList = await MylistMangaStore.getMylist();

    /// If the manga is completed, then set userStatus to completed
    if (event.mylistModel.userProgress + 1 ==
        event.mylistModel.episodesOrChapters) {
      await MylistMangaStore.saveMylist(
        mylistModel: event.mylistModel.copyWith(
          userProgress: event.mylistModel.userProgress + 1,
          userStatus: StatusManga.completed,
        ),
      );
    } else {
      await MylistMangaStore.saveMylist(
        mylistModel: event.mylistModel
            .copyWith(userProgress: event.mylistModel.userProgress + 1),
      );
    }

    for (var element in mangaList) {
      if (element.malId == event.mylistModel.malId) {
        mangaList.replaceRange(
          mangaList.indexOf(element),
          mangaList.indexOf(element) + 1,
          [
            event.mylistModel.copyWith(
              userProgress: event.mylistModel.userProgress + 1,
            ),
          ],
        );
      }
    }

    emit(
      MylistMangaLoad(
        mangaList: mangaList.cast<MylistModel>().reversed.toList(),
      ),
    );
  }
}
