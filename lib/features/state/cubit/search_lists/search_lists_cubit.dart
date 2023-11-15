import 'package:bloc/bloc.dart';

import '../../../../data/models/anime/anime_search_model.dart';
import '../../../../data/models/characters/characters_search_model.dart';
import '../../../../data/models/manga/manga_search_model.dart';
import '../../../../data/models/people/people_search_model.dart';

class SearchListsCubit extends Cubit<List> {
  SearchListsCubit() : super([]);

  List<Datum> animeList = [];
  List<MangaDatum> mangaList = [];
  List<CharactersDatum> charactersList = [];
  List<PeopleDatum> peopleList = [];
  // ! users

  void clearLists() {
    animeList.clear();
    mangaList.clear();
    charactersList.clear();
    peopleList.clear();
  }
}
