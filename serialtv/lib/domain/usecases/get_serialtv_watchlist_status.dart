import 'package:serialtv/domain/repositories/serialtv_repository.dart';

class GetWatchListStatusSerialTv {
  final SerialTvRepository serialTvRepository;

  GetWatchListStatusSerialTv(this.serialTvRepository);

  Future<bool> execute(int id) async {
    return serialTvRepository.isSerialTvAddedToWatchlist(id);
  }
}
