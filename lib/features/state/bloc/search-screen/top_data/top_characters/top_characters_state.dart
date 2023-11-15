part of 'top_characters_bloc.dart';

abstract class TopCharactersState extends Equatable {
  const TopCharactersState();
}

class TopCharactersInitial extends TopCharactersState {
  @override
  List<Object> get props => [];
}

class TopCharactersLoadState extends TopCharactersState {
  final TopCharactersModel topCharactersModel;

  const TopCharactersLoadState({
    required this.topCharactersModel,
  });

  @override
  List<Object> get props => [topCharactersModel];
}

class TopCharactersErrorState extends TopCharactersState {
  final String message;

  const TopCharactersErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
