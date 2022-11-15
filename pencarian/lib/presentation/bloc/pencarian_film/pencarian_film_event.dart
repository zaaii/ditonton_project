part of 'pencarian_film_bloc.dart';

abstract class SearchFilmEvent extends Equatable {
  const SearchFilmEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedFilm extends SearchFilmEvent {
  final String query;
  const OnQueryChangedFilm(this.query);

  @override
  List<Object> get props => [query];
}