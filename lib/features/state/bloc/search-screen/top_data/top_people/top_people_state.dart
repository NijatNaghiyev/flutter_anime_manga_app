part of 'top_people_bloc.dart';

abstract class TopPeopleState extends Equatable {
  const TopPeopleState();
}

class TopPeopleInitial extends TopPeopleState {
  @override
  List<Object> get props => [];
}

class TopPeopleLoadState extends TopPeopleState {
  final TopPeopleModel topPeopleModel;
  const TopPeopleLoadState({required this.topPeopleModel});

  @override
  List<Object> get props => [topPeopleModel];
}

class TopPeopleErrorState extends TopPeopleState {
  final String message;
  const TopPeopleErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
