import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/repositories/serialtv_repository.dart';

class GetRecommendationsSerialTv {
  final SerialTvRepository serialTvRepository;

  GetRecommendationsSerialTv(this.serialTvRepository);

  Future<Either<Failure, List<SerialTv>>> execute(id) {
    return serialTvRepository.getRecommendationsSerialTv(id);
  }
}
