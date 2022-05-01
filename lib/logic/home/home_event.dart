part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class InitHome extends HomeEvent {
  const InitHome();
}

class LoadHome extends HomeEvent {
  const LoadHome();
}

class SearchHome extends HomeEvent {
  final String search;
  const SearchHome(this.search);
}
