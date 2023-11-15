part of 'top_characters_bloc.dart';

abstract class TopCharactersEvent extends Equatable {
  const TopCharactersEvent();
}

class TopCharactersLoadEvent extends TopCharactersEvent {
  const TopCharactersLoadEvent();

  @override
  List<Object?> get props => [];
}
