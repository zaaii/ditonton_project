import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv_genre.dart';


class DetailSerialTv extends Equatable {
  DetailSerialTv({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.firstAirDate,
    required this.genres,
    required this.posterPath,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final String firstAirDate;
  final int id;
  final String name;
  final String overview;
  final List<SerialTvGenre> genres;
  final String posterPath;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
    backdropPath,
    firstAirDate,
    genres,
    id,
    name,
    overview,
    posterPath,
    numberOfEpisodes,
    numberOfSeasons,
    voteAverage,
    voteCount
  ];
}