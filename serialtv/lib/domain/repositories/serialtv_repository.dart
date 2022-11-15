import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';

abstract class SerialTvRepository {
  Future<Either<Failure, List<SerialTv>>> getNowPlayingSerialTv();
  Future<Either<Failure, List<SerialTv>>> getSerialTvPopuler();
  Future<Either<Failure, List<SerialTv>>> getSerialTvTopRated();
  Future<Either<Failure, DetailSerialTv>> getDetailSerialTv(int id);
  Future<Either<Failure, List<SerialTv>>> getRecommendationsSerialTv(int id);
  Future<Either<Failure, List<SerialTv>>> searchSerialTv(String query);
  Future<Either<Failure, String>> saveWatchlistSerialTv(DetailSerialTv serialtv);
  Future<Either<Failure, String>> removeWatchlistSerialTv(DetailSerialTv serialtv);
  Future<bool> isSerialTvAddedToWatchlist(int id);
  Future<Either<Failure, List<SerialTv>>> getWatchlistSerialTv();
}