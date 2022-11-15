import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:serialtv/data/datasources/serialtv_local_data_source.dart';
import 'package:serialtv/data/datasources/serialtv_remote_data_source.dart';
import 'package:serialtv/data/models/serialtv_table.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';
import 'package:serialtv/domain/repositories/serialtv_repository.dart';

class SerialTvRepositoryImpl implements SerialTvRepository {
  final SerialTvRemoteDataSource serialTvRemoteDataSource;
  final SerialTvLocalDataSource serialTvLocalDataSource;

  SerialTvRepositoryImpl({
    required this.serialTvRemoteDataSource,
    required this.serialTvLocalDataSource,
  });

  @override
  Future<Either<Failure, List<SerialTv>>> getNowPlayingSerialTv() async {
    try {
      final result = await serialTvRemoteDataSource
          .getNowPlayingSerialTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailSerialTv>> getDetailSerialTv(int id) async {
    try {
      final result = await serialTvRemoteDataSource
          .getDetailSerialTv(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SerialTv>>> getRecommendationsSerialTv(int id) async {
    try {
      final result = await serialTvRemoteDataSource
          .getRecommendationsSerialTv(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SerialTv>>> getSerialTvPopuler() async {
    try {
      final result = await serialTvRemoteDataSource
          .getSerialTvPopuler();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SerialTv>>> getSerialTvTopRated() async {
    try {
      final result = await serialTvRemoteDataSource
          .getSerialTvTopRated();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SerialTv>>> searchSerialTv(String query) async {
    try {
      final result = await serialTvRemoteDataSource
          .searchSerialTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal Terhubung Ke Internet'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Sertifikat Tidak Valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistSerialTv(DetailSerialTv serialtv) async {
    try {
      final result = await serialTvLocalDataSource
          .insertWatchlistSerialTv(SerialTvTable.fromEntity(serialtv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistSerialTv(DetailSerialTv serialtv) async {
    try {
      final result = await serialTvLocalDataSource
          .removeWatchlistSerialTv(SerialTvTable.fromEntity(serialtv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isSerialTvAddedToWatchlist(int id) async {
    final result = await serialTvLocalDataSource
        .getSerialTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<SerialTv>>> getWatchlistSerialTv() async {
    final result = await serialTvLocalDataSource
        .getWatchlistSerialTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}