import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/repositories/film_repository.dart';

class GetFilmPopuler {
  final FilmRepository filmRepository;

  GetFilmPopuler(this.filmRepository);

  Future<Either<Failure, List<Film>>> execute() {
    return filmRepository.getFilmPopuler();
  }
}
