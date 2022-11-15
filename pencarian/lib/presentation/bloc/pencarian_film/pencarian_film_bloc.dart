import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:film/domain/entities/film.dart';
import 'package:pencarian/domain/usecases/pencarian_film.dart';

part 'pencarian_film_event.dart';
part 'pencarian_film_state.dart';

class SearchFilmBloc extends Bloc<SearchFilmEvent, SearchFilmState> {
  final SearchFilm _searchFilm;

  SearchFilmBloc(this._searchFilm) : super(SearchFilmEmpty()) {
    on<OnQueryChangedFilm>((event, emit) async {
      emit(SearchFilmLoading());
      final searchFilmresult = await _searchFilm.execute(event.query);

      searchFilmresult.fold(
            (failure) => emit(SearchFilmError(failure.message)),
            (searchfilmdata) => emit(SearchFilmHasData(searchfilmdata)),
      );
    },
      transformer: filmDebounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> filmDebounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}