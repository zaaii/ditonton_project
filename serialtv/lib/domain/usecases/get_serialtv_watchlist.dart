import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/repositories/serialtv_repository.dart';

class GetWatchlistSerialTv {
  final SerialTvRepository _serialTvRepository;

  GetWatchlistSerialTv(this._serialTvRepository);

  Future<Either<Failure, List<SerialTv>>> execute() {
    return _serialTvRepository.getWatchlistSerialTv();
  }
}
