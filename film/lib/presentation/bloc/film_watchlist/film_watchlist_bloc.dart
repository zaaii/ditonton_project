import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/entities/film_detail.dart';
import 'package:film/domain/usecases/get_film_watchlist_status.dart';
import 'package:film/domain/usecases/get_film_watchlist.dart';
import 'package:film/domain/usecases/remove_film_watchlist.dart';
import 'package:film/domain/usecases/save_film_watchlist.dart';

part 'film_watchlist_event.dart';

part 'film_watchlist_state.dart';

class WatchlistFilmBloc extends Bloc<WatchlistFilmEvent, WatchlistFilmState> {
  final GetWatchlistFilm _getWatchlistFilm;
  final GetWatchListStatusFilm _getWatchListStatusFilm;
  final SaveWatchlistFilm _saveWatchlistFilm;
  final RemoveWatchlistFilm _removeWatchlistFilm;

  WatchlistFilmBloc(this._getWatchlistFilm, this._getWatchListStatusFilm, this._saveWatchlistFilm, this._removeWatchlistFilm) : super(WatchlistFilmEmpty()) {
    on<LoadWatchlistFilm>((event, emit) async {
        emit(WatchlistFilmLoading());
        final watchlistResult = await _getWatchlistFilm.execute();

        watchlistResult.fold(
          (failure) => emit(WatchlistFilmError(failure.message)),
          (data) => emit(WatchlistFilmHasData(data)),
        );
      },
    );

    on<LoadWatchListStatusFilm>(((event, emit) async {
      final id = event.id;
      final result = await _getWatchListStatusFilm.execute(id);

      emit(WatchlistFilmStatus(result));
    }));

    on<AddWatchlistFilm>((event, emit) async {
      final film = event.film;
      final result = await _saveWatchlistFilm.execute(film);

      result.fold(
          (failure) => emit(WatchlistFilmError(failure.message)),
          (successNotif) => emit(const WatchlistFilmSuccess('Film Ditambahkan ke Watchlist')));

      add(LoadWatchListStatusFilm(film.id));
    });

    on<DeleteWatchlistFilm>((event, emit) async {
      final film = event.film;
      final result = await _removeWatchlistFilm.execute(film);

      result.fold(
          (failure) => emit(WatchlistFilmError(failure.message)),
          (successNotif) => emit(const WatchlistFilmSuccess('Film Dihapus dari Watchlist')));

      add(LoadWatchListStatusFilm(film.id));
    });
  }
}
