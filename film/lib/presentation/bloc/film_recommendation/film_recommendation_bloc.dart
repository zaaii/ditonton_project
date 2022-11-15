import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_recommendations.dart';

part 'film_recommendation_event.dart';

part 'film_recommendation_state.dart';

class RecommendationsFilmBloc
    extends Bloc<RecommendationsFilmEvent, RecommendationsFilmState> {
  final GetRecommendationsFilm _getRecommendationsFilm;

  RecommendationsFilmBloc(this._getRecommendationsFilm) : super(RecommendationsFilmEmpty()) {
    on<FetchRecommendationsFilm>((event, emit) async {
        final id = event.id;

        emit(RecommendationsFilmLoading());
        final recommendationsResult = await _getRecommendationsFilm.execute(id);

        recommendationsResult.fold(
          (failure) => emit(RecommendationsFilmError(failure.message)),
          (data) => emit(RecommendationsFilmHasData(data))
        );
      },
    );
  }
}
