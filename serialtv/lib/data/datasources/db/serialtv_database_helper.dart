import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:serialtv/data/models/serialtv_table.dart';

class SerialTvDatabaseHelper {
  static SerialTvDatabaseHelper? _serialTvDatabaseHelper;
  SerialTvDatabaseHelper._instance() {
    _serialTvDatabaseHelper = this;
  }

  factory SerialTvDatabaseHelper() => _serialTvDatabaseHelper ?? SerialTvDatabaseHelper._instance();
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistSerialTv = 'serialtvwatchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/db_serialtv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistSerialTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistSerialTv(SerialTvTable serialtv) async {
    final db = await database;
    return await db!.insert(_tblWatchlistSerialTv, serialtv.toJson());
  }

  Future<int> removeWatchlistSerialTv(SerialTvTable serialtv) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistSerialTv,
      where: 'id = ?',
      whereArgs: [serialtv.id],
    );
  }

  Future<Map<String, dynamic>?> getSerialTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistSerialTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistSerialTv() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistSerialTv);

    return results;
  }
}
