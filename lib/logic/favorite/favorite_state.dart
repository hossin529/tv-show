part of 'favorite_bloc.dart';

enum FavoriteStatus { initial, loading, loaded, error }

class FavoriteState extends Equatable {
  const FavoriteState(
      {this.tvShows = const [],
      this.message,
      this.status = FavoriteStatus.initial});

  final List<TvShow> tvShows;
  final FavoriteStatus status;
  final String? message;

  FavoriteState copyWith(
      {List<TvShow>? tvShows, String? message, FavoriteStatus? status}) {
    return FavoriteState(
      tvShows: tvShows ?? this.tvShows,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status];
}

class FavoriteInitial extends FavoriteState {}
