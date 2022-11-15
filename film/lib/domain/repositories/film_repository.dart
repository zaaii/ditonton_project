import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/entities/film_detail.dart';

abstract class FilmRepository {
  Future<Either<Failure, List<Film>>> getNowPlayingFilm();
  Future<Either<Failure, List<Film>>> getFilmPopuler();
  Future<Either<Failure, List<Film>>> getFilmTopRated();
  Future<Either<Failure, DetailFilm>> getDetailFilm(int id);
  Future<Either<Failure, List<Film>>> getRecommendationsFilm(int id);
  Future<Either<Failure, List<Film>>> searchFilm(String query);
  Future<Either<Failure, String>> saveWatchlistFilm(DetailFilm film);
  Future<Either<Failure, String>> removeWatchlistFilm(DetailFilm film);
  Future<bool> isFilmAddedToWatchlist(int id);
  Future<Either<Failure, List<Film>>> getWatchlistFilm();
}
