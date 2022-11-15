import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film_detail.dart';
import 'package:film/domain/repositories/film_repository.dart';

class GetDetailFilm {
  final FilmRepository filmrepository;

  GetDetailFilm(this.filmrepository);

  Future<Either<Failure, DetailFilm>> execute(int id) {
    return filmrepository.getDetailFilm(id);
  }
}
