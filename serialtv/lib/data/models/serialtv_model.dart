import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv.dart';

class SerialTvModel extends Equatable {
  SerialTvModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.backdropPath,
    required this.voteAverage,
    required this.firstAirDate,
    required this.genreIds,
    required this.voteCount,
    required this.name,
  });

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  factory SerialTvModel.fromJson(Map<String, dynamic> json) => SerialTvModel(
    backdropPath: json["backdrop_path"],
    id: json["id"],
    originalName: json["original_name"],
    overview: json["overview"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    firstAirDate: json["first_air_date"],
    name: json["name"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": firstAirDate,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  SerialTv toEntity() {
    return SerialTv(
      backdropPath: backdropPath,
      id: id,
      originalName: originalName,
      overview: overview,
      genreIds: genreIds,
      popularity: this.popularity,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
    backdropPath,
    id,
    originalName,
    overview,
    genreIds,
    popularity,
    posterPath,
    firstAirDate,
    name,
    voteAverage,
    voteCount,
  ];
}
