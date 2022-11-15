part of 'film_watchlist_bloc.dart';

abstract class WatchlistFilmEvent extends Equatable {
  const WatchlistFilmEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistFilm extends WatchlistFilmEvent {}

class LoadWatchListStatusFilm extends WatchlistFilmEvent {
  final int id;
  const LoadWatchListStatusFilm(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistFilm extends WatchlistFilmEvent {
  final DetailFilm film;
  const AddWatchlistFilm(this.film);

  @override
  List<Object> get props => [film];
}

class DeleteWatchlistFilm extends WatchlistFilmEvent {
  final DetailFilm film;
  const DeleteWatchlistFilm(this.film);

  @override
  List<Object> get props => [film];
}