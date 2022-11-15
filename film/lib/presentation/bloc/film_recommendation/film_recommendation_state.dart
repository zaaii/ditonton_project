part of 'film_recommendation_bloc.dart';

abstract class RecommendationsFilmState extends Equatable {
  const RecommendationsFilmState();

  @override
  List<Object> get props => [];
}

class RecommendationsFilmEmpty extends RecommendationsFilmState {}

class RecommendationsFilmLoading extends RecommendationsFilmState {}

class RecommendationsFilmError extends RecommendationsFilmState {
  final String message;
  const RecommendationsFilmError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationsFilmHasData extends RecommendationsFilmState {
  final List<Film> result;
  const RecommendationsFilmHasData(this.result);

  @override
  List<Object> get props => [result];
}