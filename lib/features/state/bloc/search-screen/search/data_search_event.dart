part of 'data_search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchInitialEvent extends SearchEvent {
  @override
  List<Object> get props => [];
}

class DataSearchSearchEvent extends SearchEvent {
  final SearchType searchType;
  final String query;

  const DataSearchSearchEvent({
    required this.searchType,
    required this.query,
  });

  @override
  List<Object> get props => [query];
}

class SearchHistoryEvent extends SearchEvent {
  @override
  List<Object> get props => [];
}
