import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_nowplaying.dart';

part 'film_nowplaying_event.dart';
part 'film_nowplaying_state.dart';

class NowPlayingFilmBloc extends Bloc<NowPlayingFilmEvent, NowPlayingFilmState> {
  final GetNowPlayingFilm _getNowPlayingFilm;

  NowPlayingFilmBloc(this._getNowPlayingFilm) : super(NowPlayingFilmEmpty()) {
    on<FetchNowPlayingFilm>((event, emit) async {
        emit(NowPlayingFilmLoading());
        final nowPlayingResult = await _getNowPlayingFilm.execute();

        nowPlayingResult.fold(
              (failure) => emit(NowPlayingFilmError(failure.message)),
              (data) => emit(NowPlayingFilmHasData(data))
        );
      },
    );
  }
}