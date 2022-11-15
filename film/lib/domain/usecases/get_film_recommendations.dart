import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/repositories/film_repository.dart';

class GetRecommendationsFilm {
  final FilmRepository filmRepository;

  GetRecommendationsFilm(this.filmRepository);

  Future<Either<Failure, List<Film>>> execute(id) {
    return filmRepository.getRecommendationsFilm(id);
  }
}
