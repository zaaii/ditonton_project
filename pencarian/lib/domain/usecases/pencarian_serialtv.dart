import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/repositories/serialtv_repository.dart';

class SearchSerialTv {
  final SerialTvRepository serialTvRepository;
  SearchSerialTv(this.serialTvRepository);

  Future<Either<Failure, List<SerialTv>>> execute(String query) {
    return serialTvRepository.searchSerialTv(query);
  }
}

