part of 'film_recommendation_bloc.dart';

abstract class RecommendationsFilmEvent extends Equatable {
  const RecommendationsFilmEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationsFilm extends RecommendationsFilmEvent {
  final int id;
  const FetchRecommendationsFilm(this.id);

  @override
  List<Object> get props => [id];
}