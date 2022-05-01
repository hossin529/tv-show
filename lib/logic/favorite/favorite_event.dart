part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class InitFavorite extends FavoriteEvent {
  const InitFavorite();
}

class LoadFavorite extends FavoriteEvent {
  const LoadFavorite();
}

class AddFavorite extends FavoriteEvent {
  final TvShow tvShow;
  const AddFavorite(this.tvShow);
}

class RemoveFavorite extends FavoriteEvent {
  final TvShow tvShow;
  const RemoveFavorite(this.tvShow);
}
