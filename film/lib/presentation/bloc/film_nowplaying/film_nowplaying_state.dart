part of 'film_nowplaying_bloc.dart';

abstract class NowPlayingFilmState extends Equatable {
  const NowPlayingFilmState();

  @override
  List<Object> get props => [];
}

class NowPlayingFilmLoading extends NowPlayingFilmState {}

class NowPlayingFilmEmpty extends NowPlayingFilmState {}

class NowPlayingFilmError extends NowPlayingFilmState {
  final String message;
  const NowPlayingFilmError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingFilmHasData extends NowPlayingFilmState {
  final List<Film> result;
  const NowPlayingFilmHasData(this.result);

  @override
  List<Object> get props => [result];
}