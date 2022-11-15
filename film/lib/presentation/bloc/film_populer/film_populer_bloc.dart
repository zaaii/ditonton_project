import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_populer.dart';

part 'film_populer_event.dart';
part 'film_populer_state.dart';

class FilmPopulerBloc extends Bloc<FilmPopulerEvent, FilmPopulerState> {
  final GetFilmPopuler _getFilmPopuler;

  FilmPopulerBloc(this._getFilmPopuler) : super(FilmPopulerEmpty()) {
    on<FetchFilmPopuler>((event, emit) async {
        emit(FilmPopulerLoading());
        final populerResult = await _getFilmPopuler.execute();

        populerResult.fold(
              (failure) => emit(FilmPopulerError(failure.message)),
              (data) => emit(FilmPopulerHasData(data))
        );
      },
    );
  }
}