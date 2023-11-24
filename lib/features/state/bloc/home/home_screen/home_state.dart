part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeStateAction extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeStateAction {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final List<dynamic> allList;

  const HomeLoadedState({
    required this.allList,
  });

  @override
  List<Object> get props => [allList];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
