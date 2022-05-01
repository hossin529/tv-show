import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_shows/data/models/tv_show.dart';

class FavoriteStorage {
  Future<void> addFavorite(TvShow tvShow) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var tvShows = await getFavorits();
    tvShows.add(tvShow);

    final String encodedData = encode(tvShows);

    await prefs.setString('tv_shows', encodedData);
  }

  Future<void> removeFavorite(TvShow tvShow) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var tvShows = await getFavorits();
    final tvShowsUpdated = tvShows.where((ad) => ad.id != tvShow.id).toList();

    final String encodedData = encode(tvShowsUpdated);

    await prefs.setString('tv_shows', encodedData);
  }

  Future<List<TvShow>> getFavorits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Fetch and decode data
    final String? musicsString = prefs.getString('tv_shows');

    return musicsString == null ? [] : decode(musicsString);
  }

  static String encode(List<TvShow> tvShows) => json.encode(
        tvShows.map<Map<String, dynamic>>((tvShow) => tvShow.toJson()).toList(),
      );

  static List<TvShow> decode(String? tvShows) =>
      (json.decode(tvShows!) as List<dynamic>)
          .map<TvShow>((item) => TvShow.fromJson(item))
          .toList();
}
