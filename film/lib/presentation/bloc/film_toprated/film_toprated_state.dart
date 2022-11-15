part of 'film_toprated_bloc.dart';

abstract class FilmTopRatedState extends Equatable {
  const FilmTopRatedState();

  @override
  List<Object> get props => [];
}

class FilmTopRatedLoading extends FilmTopRatedState {}

class FilmTopRatedEmpty extends FilmTopRatedState {}

class FilmTopRatedError extends FilmTopRatedState {
  final String message;
  const FilmTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class FilmTopRatedHasData extends FilmTopRatedState {
  final List<Film> result;
  const FilmTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}