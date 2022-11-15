part of 'film_watchlist_bloc.dart';

abstract class WatchlistFilmState extends Equatable {
  const WatchlistFilmState();

  @override
  List<Object> get props => [];
}
class WatchlistFilmLoading extends WatchlistFilmState {}

class WatchlistFilmEmpty extends WatchlistFilmState {}

class WatchlistFilmError extends WatchlistFilmState {
  final String message;
  const WatchlistFilmError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistFilmHasData extends WatchlistFilmState {
  final List<Film> result;
  const WatchlistFilmHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistFilmSuccess extends WatchlistFilmState {
  final String message;
  const WatchlistFilmSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistFilmStatus extends WatchlistFilmState {
  final bool isFilmAdded;
  const WatchlistFilmStatus(this.isFilmAdded);

  @override
  List<Object> get props => [isFilmAdded];
}