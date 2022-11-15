part of 'pencarian_film_bloc.dart';

abstract class SearchFilmState extends Equatable {
  const SearchFilmState();

  @override
  List<Object> get props => [];
}

class SearchFilmLoading extends SearchFilmState {}

class SearchFilmEmpty extends SearchFilmState {}

class SearchFilmError extends SearchFilmState {
  final String message;
  SearchFilmError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchFilmHasData extends SearchFilmState {
  final List<Film> filmresult;

  SearchFilmHasData(this.filmresult);

  @override
  List<Object> get props => [filmresult];
}