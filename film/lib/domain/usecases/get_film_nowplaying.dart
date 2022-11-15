import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/repositories/film_repository.dart';

class GetNowPlayingFilm {
  final FilmRepository filmRepository;

  GetNowPlayingFilm(this.filmRepository);

  Future<Either<Failure, List<Film>>> execute() {
    return filmRepository.getNowPlayingFilm();
  }
}
