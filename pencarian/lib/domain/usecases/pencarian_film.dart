import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/repositories/film_repository.dart';

class SearchFilm {
  final FilmRepository filmRepository;
  SearchFilm(this.filmRepository);

  Future<Either<Failure, List<Film>>> execute(String query) {
    return filmRepository.searchFilm(query);
  }
}
