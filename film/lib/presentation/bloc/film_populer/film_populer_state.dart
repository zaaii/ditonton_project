part of 'film_populer_bloc.dart';

abstract class FilmPopulerState extends Equatable {
  const FilmPopulerState();

  @override
  List<Object> get props => [];
}

class FilmPopulerLoading extends FilmPopulerState {}

class FilmPopulerEmpty extends FilmPopulerState {}

class FilmPopulerError extends FilmPopulerState {
  final String message;
  const FilmPopulerError(this.message);

  @override
  List<Object> get props => [message];
}

class FilmPopulerHasData extends FilmPopulerState {
  final List<Film> result;
  const FilmPopulerHasData(this.result);

  @override
  List<Object> get props => [result];
}