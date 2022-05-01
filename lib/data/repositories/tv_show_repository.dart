import 'package:tv_shows/data/api/tv_show_api.dart';
import 'package:tv_shows/data/models/tv_show.dart';

class TvShowRepository {
  final TvShowApi _tvShowApi = TvShowApi();

  List<TvShow> tvShows = [];

  Future<List<TvShow>> getHomeTvShows({int page = 1, String? search}) async {
    List<TvShow> tvShows = [];
    var respons = await _tvShowApi.getTvShows(page: page, search: search);
    for (final offer in respons['results']) {
      tvShows.add(TvShow.fromJson(offer));
    }

    return tvShows;
  }
}
