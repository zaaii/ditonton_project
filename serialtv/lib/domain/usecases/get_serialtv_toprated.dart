import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/repositories/serialtv_repository.dart';

class GetSerialTvTopRated {
  final SerialTvRepository serialTvRepository;
  GetSerialTvTopRated(this.serialTvRepository);

  Future<Either<Failure, List<SerialTv>>> execute() {
    return serialTvRepository.getSerialTvTopRated();
  }
}
