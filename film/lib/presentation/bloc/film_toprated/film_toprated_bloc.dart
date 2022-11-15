import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_toprated.dart';

part 'film_toprated_event.dart';
part 'film_toprated_state.dart';

class FilmTopRatedBloc extends Bloc<FilmTopRatedEvent, FilmTopRatedState> {
  final GetFilmTopRated _getFilmTopRated;

  FilmTopRatedBloc(this._getFilmTopRated) : super(FilmTopRatedEmpty()) {
    on<FetchFilmTopRated>((event, emit) async {
        emit(FilmTopRatedLoading());
        final topRatedResult = await _getFilmTopRated.execute();

        topRatedResult.fold(
              (failure) => emit(FilmTopRatedError(failure.message)),
              (data) => emit(FilmTopRatedHasData(data))
        );
      },
    );
  }
}