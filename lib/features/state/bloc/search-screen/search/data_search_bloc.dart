import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/data/services/search/characters_search.dart';
import 'package:flutter_anime_manga_app/data/services/search/people_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/anime/anime_search_model.dart';
import '../../../../../data/models/characters/characters_search_model.dart';
import '../../../../../data/models/manga/manga_search_model.dart';
import '../../../../../data/models/people/people_search_model.dart';
import '../../../../../data/services/search/anime_search.dart';
import '../../../../../data/services/search/manga_search.dart';

part 'data_search_event.dart';
part 'data_search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AnimeSearch animeSearch;
  final MangaSearch mangaSearch;
  final CharactersSearch charactersSearch;
  final PeopleSearch peopleSearch;

  String parameterType = 'Default';
  String orderByType = 'Default';
  String queryBloc = '';
  int page = 1;

  SearchBloc({
    required this.charactersSearch,
    required this.animeSearch,
    required this.mangaSearch,
    required this.peopleSearch,
  }) : super(SearchInitial()) {
    on<DataSearchSearchEvent>(dataSearchSearchEvent);
    on<SearchInitialEvent>(searchInitialEvent);
    on<SearchHistoryEvent>(searchHistoryEvent);
  }

  Future<FutureOr<void>> dataSearchSearchEvent(
      DataSearchSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState(query: queryBloc));

    queryBloc = event.query;
    switch (event.searchType) {
      case SearchType.anime:
        final response = await animeSearch.searchAnime(
          query: queryBloc,
          searchType: parameterType,
          orderBy: orderByType,
          page: page,
        );
        if (response != null) {
          emit(SearchLoadedAnimeState(animeList: response));
        } else {
          emit(const SearchErrorState(message: 'Something went wrong'));
        }
      case SearchType.manga:
        final response = await mangaSearch.searchManga(
          query: queryBloc,
          searchType: parameterType,
          orderBy: orderByType,
          page: page,
        );
        if (response != null) {
          emit(SearchLoadedMangaState(mangaList: response));
        } else {
          emit(const SearchErrorState(message: 'Something went wrong'));
        }
      case SearchType.characters:
        final response = await charactersSearch.searchCharacters(
          query: queryBloc,
          orderBy: orderByType,
          page: page,
        );
        if (response != null) {
          emit(SearchLoadedCharactersState(charactersList: response));
        } else {
          emit(const SearchErrorState(message: 'Something went wrong'));
        }
      case SearchType.people:
        final response = await peopleSearch.searchPeople(
          query: queryBloc,
          orderBy: orderByType,
          page: page,
        );
        if (response != null) {
          emit(SearchLoadedPeopleState(peopleList: response));
        } else {
          emit(const SearchErrorState(message: 'Something went wrong'));
        }
      case SearchType.users:
      // TODO: Handle this case.
    }
  }

  FutureOr<void> searchInitialEvent(
      SearchInitialEvent event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }

  FutureOr<void> searchHistoryEvent(
      SearchHistoryEvent event, Emitter<SearchState> emit) {
    emit(const SearchHistoryState());
  }
}
