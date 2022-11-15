import 'package:equatable/equatable.dart';

class SerialTv extends Equatable {
  SerialTv({
    required this.backdropPath,
    required this.id,
    required this.originalName,
    required this.firstAirDate,
    required this.genreIds,
    required this.name,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  SerialTv.watchlist({
    this.originalName,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  String? backdropPath;
  String? firstAirDate;
  final int id;
  final String? originalName;
  List<int>? genreIds;
  final String? name;
  final String? overview;
  double? popularity;
  final String? posterPath;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
    backdropPath,
    firstAirDate,
    genreIds,
    id,
    name,
    originalName,
    overview,
    popularity,
    posterPath,
    voteAverage,
    voteCount,
  ];
}