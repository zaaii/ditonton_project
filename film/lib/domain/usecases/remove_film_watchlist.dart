import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:film/domain/entities/film_detail.dart';
import 'package:film/domain/repositories/film_repository.dart';

class RemoveWatchlistFilm {
  final FilmRepository filmRepository;
  RemoveWatchlistFilm(this.filmRepository);

  Future<Either<Failure, String>> execute(DetailFilm film) {
    return filmRepository.removeWatchlistFilm(film);
  }
}
