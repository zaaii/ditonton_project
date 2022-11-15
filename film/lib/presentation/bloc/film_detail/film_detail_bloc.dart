import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:film/domain/entities/film_detail.dart';
import 'package:film/domain/usecases/get_film_detail.dart';

part 'film_detail_event.dart';
part 'film_detail_state.dart';

class DetailFilmBloc extends Bloc<DetailFilmEvent, DetailFilmState> {
  final GetDetailFilm _getDetailFilm;

  DetailFilmBloc(this._getDetailFilm) : super(DetailFilmEmpty()) {
    on<FetchDetailFilm>((event, emit) async {
      final id = event.id;

      emit(DetailFilmLoading());
      final detailResult = await _getDetailFilm.execute(id);

      detailResult.fold(
            (failure) => emit(DetailFilmError(failure.message)),
            (data) => emit(DetailFilmHasData(data))
        );
      },
    );
  }
}