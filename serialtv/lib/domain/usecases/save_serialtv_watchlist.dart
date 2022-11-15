import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';
import 'package:serialtv/domain/repositories/serialtv_repository.dart';

class SaveWatchlistSerialTv {
  final SerialTvRepository serialTvRepository;

  SaveWatchlistSerialTv(this.serialTvRepository);

  Future<Either<Failure, String>> execute(DetailSerialTv serialtv) {
    return serialTvRepository.saveWatchlistSerialTv(serialtv);
  }
}
