import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/repositories/film_repository.dart';

class GetWatchlistFilm {
  final FilmRepository _filmRepository;

  GetWatchlistFilm(this._filmRepository);

  Future<Either<Failure, List<Film>>> execute() {
    return _filmRepository.getWatchlistFilm();
  }
}

