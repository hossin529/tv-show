import 'package:tv_shows/data/api/tv_show_api.dart';
import 'package:tv_shows/data/models/tv_show.dart';

class TvShowRepository {
  static final TvShowRepository _tvShowRepository =
      TvShowRepository._internal();

  factory TvShowRepository() {
    return _tvShowRepository;
  }

  final TvShowApi _tvShowApi = TvShowApi();
  TvShowRepository._internal();

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
