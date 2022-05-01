import 'package:tv_shows/config/app_config.dart';

class TvShow {
  String? firstAirDate;
  int? id;
  String? originalName;
  String? name;
  String? overview;
  String? posterPath;

  TvShow(
      {this.firstAirDate,
      this.id,
      this.originalName,
      this.name,
      this.overview,
      this.posterPath});

  TvShow.fromJson(Map<String, dynamic> json) {
    firstAirDate = json['first_air_date'];
    id = json['id'];
    originalName = json['original_name'];
    name = json['name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_air_date'] = this.firstAirDate;
    data['id'] = this.id;
    data['original_name'] = this.originalName;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    return data;
  }

  String? get posterFullPath => '${AppConfig.imagePath}${this.posterPath}';
}
