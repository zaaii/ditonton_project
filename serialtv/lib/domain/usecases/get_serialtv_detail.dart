import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';
import 'package:serialtv/domain/repositories/serialtv_repository.dart';

class GetDetailSerialTv {
  final SerialTvRepository serialTvRepository;

  GetDetailSerialTv(this.serialTvRepository);

  Future<Either<Failure, DetailSerialTv>> execute(int id) {
    return serialTvRepository.getDetailSerialTv(id);
  }
}
