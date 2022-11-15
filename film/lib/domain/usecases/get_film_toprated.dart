import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/repositories/film_repository.dart';

class GetFilmTopRated {
  final FilmRepository filmRepository;

  GetFilmTopRated(this.filmRepository);

  Future<Either<Failure, List<Film>>> execute() {
    return filmRepository.getFilmTopRated();
  }
}