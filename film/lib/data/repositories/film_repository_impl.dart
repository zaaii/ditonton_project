import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:film/data/datasources/film_local_data_source.dart';
import 'package:film/data/datasources/film_remote_data_source.dart';
import 'package:film/data/models/film_table.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/entities/film_detail.dart';
import 'package:film/domain/repositories/film_repository.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmRemoteDataSource filmremoteDataSource;
  final FilmLocalDataSource filmlocalDataSource;

  FilmRepositoryImpl({
    required this.filmremoteDataSource,
    required this.filmlocalDataSource,
  });

  @override
  Future<Either<Failure, List<Film>>> getNowPlayingFilm() async {
    try {
      final result = await filmremoteDataSource.getNowPlayingFilm();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailFilm>> getDetailFilm(int id) async {
    try {
      final result = await filmremoteDataSource.getDetailFilm(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Film>>> getRecommendationsFilm(int id) async {
    try {
      final result = await filmremoteDataSource.getRecommendationsFilm(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Film>>> getFilmPopuler() async {
    try {
      final result = await filmremoteDataSource.getFilmPopuler();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Film>>> getFilmTopRated() async {
    try {
      final result = await filmremoteDataSource.getFilmTopRated();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Film>>> searchFilm(String query) async {
    try {
      final result = await filmremoteDataSource.searchFilm(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistFilm(DetailFilm film) async {
    try {
      final result =
      await filmlocalDataSource.insertWatchlistFilm(FilmTable.fromEntity(film));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistFilm(DetailFilm film) async {
    try {
      final result =
      await filmlocalDataSource.removeWatchlistFilm(FilmTable.fromEntity(film));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
  @override
  Future<Either<Failure, List<Film>>> getWatchlistFilm() async {
    final result = await filmlocalDataSource.getWatchlistFilm();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isFilmAddedToWatchlist(int id) async {
    final result = await filmlocalDataSource.getFilmById(id);
    return result != null;
  }
}
