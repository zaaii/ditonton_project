part of 'film_nowplaying_bloc.dart';

abstract class NowPlayingFilmEvent extends Equatable {
  const NowPlayingFilmEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingFilm extends NowPlayingFilmEvent {}