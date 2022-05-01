import 'package:tv_shows/data/models/tv_show.dart';
import 'package:tv_shows/data/storage/favotite_storage.dart';

class favoriteRepository {
  FavoriteStorage _favoriteStorage = FavoriteStorage();

  Future<void> addFavorite(TvShow tvShow) async {
    _favoriteStorage.addFavorite(tvShow);
  }

  Future<void> removeFavorite(TvShow tvShow) async {
    _favoriteStorage.removeFavorite(tvShow);
  }

  Future<List<TvShow>> getFavorits() async {
    return _favoriteStorage.getFavorits();
  }
}
