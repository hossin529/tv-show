import 'package:tv_shows/data/api/base_api.dart';

class TvShowApi extends BaseApi {
  Future<dynamic> getTvShows({int page = 1, String? search}) async {
    var endPath = search != null ? 'search/tv' : 'tv/popular';
    return await api.httpGet(endPath, query: {
      "page": page.toString(),
      "query": search ?? '',
    });
  }
}
