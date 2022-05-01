part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  const HomeState(
      {this.tvShows = const [],
      this.hasReachedMax = false,
      this.stateUpdate = false,
      this.message,
      this.search,
      this.status = HomeStatus.initial});

  final List<TvShow> tvShows;
  final bool hasReachedMax;
  final bool stateUpdate;
  final HomeStatus status;
  final String? message;
  final String? search;

  HomeState copyWith(
      {List<TvShow>? tvShows,
      bool? hasReachedMax,
      bool? stateUpdate,
      String? message,
      String? search,
      HomeStatus? status}) {
    return HomeState(
      tvShows: tvShows ?? this.tvShows,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      stateUpdate: stateUpdate ?? this.stateUpdate,
      status: status ?? this.status,
      search: search ?? this.search,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status];
}

class HomeInitial extends HomeState {}
