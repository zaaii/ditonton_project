import 'package:core/core.dart';
import 'package:film/data/datasources/db/film_database_helper.dart';
import 'package:film/data/models/film_table.dart';

abstract class FilmLocalDataSource {
  Future<FilmTable?> getFilmById(int id);
  Future<List<FilmTable>> getWatchlistFilm();
  Future<String> insertWatchlistFilm(FilmTable film);
  Future<String> removeWatchlistFilm(FilmTable film);
}

class FilmLocalDataSourceImpl implements FilmLocalDataSource {
  final FilmDatabaseHelper filmDatabaseHelper;

  FilmLocalDataSourceImpl({required this.filmDatabaseHelper});

  @override
  Future<FilmTable?> getFilmById(int id) async {
    final result = await filmDatabaseHelper.getFilmById(id);
    if (result != null) {
      return FilmTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<FilmTable>> getWatchlistFilm() async {
    final result = await filmDatabaseHelper.getWatchlistFilm();
    return result.map((data) => FilmTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlistFilm(FilmTable film) async {
    try {
      await filmDatabaseHelper.insertWatchlistFilm(film);
      return 'Film Ditambahkan ke Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistFilm(FilmTable film) async {
    try {
      await filmDatabaseHelper.removeWatchlistFilm(film);
      return 'Film Dihapus dari Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
