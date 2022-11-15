import 'package:film/domain/entities/film_genre.dart';
import 'package:equatable/equatable.dart';

class FilmGenreModel extends Equatable {
  FilmGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory FilmGenreModel.fromJson(Map<String, dynamic> json) => FilmGenreModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  GenreFilm toEntity() {
    return GenreFilm(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
