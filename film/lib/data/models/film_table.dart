import 'package:equatable/equatable.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/entities/film_detail.dart';

class FilmTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  FilmTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory FilmTable.fromEntity(DetailFilm film) => FilmTable(
    id: film.id,
    title: film.title,
    posterPath: film.posterPath,
    overview: film.overview,
  );

  factory FilmTable.fromMap(Map<String, dynamic> map) => FilmTable(
    id: map['id'],
    title: map['title'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'posterPath': posterPath,
    'overview': overview,
  };

  Film toEntity() => Film.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    title: title,
  );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
