part of 'data_search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchStateAction extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchStateAction {
  final String query;

  SearchLoadingState({required this.query});
  @override
  List<Object> get props => [];
}

class SearchLoadedAnimeState extends SearchState {
  final AnimeSearchModel animeList;

  const SearchLoadedAnimeState({required this.animeList});

  @override
  List<Object> get props => [animeList];
}

class SearchLoadedMangaState extends SearchState {
  final MangaSearchModel mangaList;

  const SearchLoadedMangaState({required this.mangaList});

  @override
  List<Object> get props => [mangaList];
}

class SearchLoadedCharactersState extends SearchState {
  final CharactersSearchModel charactersList;

  const SearchLoadedCharactersState({required this.charactersList});

  @override
  List<Object> get props => [charactersList];
}

class SearchLoadedPeopleState extends SearchState {
  final PeopleSearchModel peopleList;

  const SearchLoadedPeopleState({required this.peopleList});

  @override
  List<Object> get props => [peopleList];
}

class SearchHistoryState extends SearchState {
  const SearchHistoryState();

  @override
  List<Object> get props => [];
}

class SearchErrorState extends SearchState {
  final String message;

  const SearchErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
