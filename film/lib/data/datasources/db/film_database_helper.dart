import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:film/data/models/film_table.dart';

class FilmDatabaseHelper {
  static FilmDatabaseHelper? _filmdatabaseHelper;
  FilmDatabaseHelper._instance() {
    _filmdatabaseHelper = this;
  }

  factory FilmDatabaseHelper() => _filmdatabaseHelper ?? FilmDatabaseHelper._instance();
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblFilmWatchlist = 'filmwatchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/db_film.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblFilmWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<Map<String, dynamic>?> getFilmById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblFilmWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistFilm() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblFilmWatchlist);

    return results;
  }

  Future<int> insertWatchlistFilm(FilmTable film) async {
    final db = await database;
    return await db!.insert(_tblFilmWatchlist, film.toJson());
  }

  Future<int> removeWatchlistFilm(FilmTable film) async {
    final db = await database;
    return await db!.delete(
      _tblFilmWatchlist,
      where: 'id = ?',
      whereArgs: [film.id],
    );
  }
}
