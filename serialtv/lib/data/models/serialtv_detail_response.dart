import 'package:equatable/equatable.dart';
import 'package:serialtv/data/models/serialtv_genre_model.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';

class SerialTvDetailResponse extends Equatable {
  SerialTvDetailResponse({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.firstAirDate,
    required this.genres,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final String firstAirDate;
  final int id;
  final String name;
  final String overview;
  final List<SerialTvGenreModel> genres;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalLanguage;
  final String originalName;
  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;

  factory SerialTvDetailResponse.fromJson(Map<String, dynamic> json) =>
      SerialTvDetailResponse(
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        genres: List<SerialTvGenreModel>.from(json["genres"].map((x) => SerialTvGenreModel.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "first_air_date": firstAirDate,
    "id": id,
    "name": name,
    "overview": overview,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "original_language": originalLanguage,
    "original_name": originalName,
    "popularity": popularity,
    "poster_path": posterPath,
    "status": status,
    "tagline": tagline,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  DetailSerialTv toEntity() {
    return DetailSerialTv(
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
    backdropPath,
    firstAirDate,
    genres,
    id,
    name,
    numberOfEpisodes,
    numberOfSeasons,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    status,
    tagline,
    voteAverage,
    voteCount,
  ];
}
