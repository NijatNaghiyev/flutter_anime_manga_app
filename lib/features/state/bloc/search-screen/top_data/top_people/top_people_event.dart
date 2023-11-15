part of 'top_people_bloc.dart';

abstract class TopPeopleEvent extends Equatable {
  const TopPeopleEvent();
}

class TopPeopleLoadEvent extends TopPeopleEvent {
  const TopPeopleLoadEvent();
  @override
  List<Object> get props => [];
}
