import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film_detail.dart';
import 'package:film/domain/repositories/film_repository.dart';

class SaveWatchlistFilm {
  final FilmRepository filmRepository;

  SaveWatchlistFilm(this.filmRepository);

  Future<Either<Failure, String>> execute(DetailFilm film) {
    return filmRepository.saveWatchlistFilm(film);
  }
}
