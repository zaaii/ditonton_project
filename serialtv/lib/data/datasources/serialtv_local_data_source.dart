import 'package:core/core.dart';
import 'package:serialtv/data/datasources/db/serialtv_database_helper.dart';
import 'package:serialtv/data/models/serialtv_table.dart';

abstract class SerialTvLocalDataSource {
  Future<SerialTvTable?> getSerialTvById(int id);
  Future<List<SerialTvTable>> getWatchlistSerialTv();
  Future<String> insertWatchlistSerialTv(SerialTvTable serialtv);
  Future<String> removeWatchlistSerialTv(SerialTvTable serialtv);
}

class SerialTvLocalDataSourceImpl implements SerialTvLocalDataSource {
  final SerialTvDatabaseHelper serialTvDatabaseHelper;

  SerialTvLocalDataSourceImpl({required this.serialTvDatabaseHelper});

  @override
  Future<SerialTvTable?> getSerialTvById(int id) async {
    final result = await serialTvDatabaseHelper.getSerialTvById(id);
    if (result != null) {
      return SerialTvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SerialTvTable>> getWatchlistSerialTv() async {
    final result = await serialTvDatabaseHelper.getWatchlistSerialTv();
    return result.map((data) => SerialTvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlistSerialTv(SerialTvTable serialtv) async {
    try {
      await serialTvDatabaseHelper.insertWatchlistSerialTv(serialtv);
      return 'Serial Tv ditambahkan kedalam Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistSerialTv(SerialTvTable serialtv) async {
    try {
      await serialTvDatabaseHelper.removeWatchlistSerialTv(serialtv);
      return 'Serial Tv dihapus dari Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
