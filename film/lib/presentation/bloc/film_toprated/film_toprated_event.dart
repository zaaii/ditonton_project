part of 'film_toprated_bloc.dart';

abstract class FilmTopRatedEvent extends Equatable {
  const FilmTopRatedEvent();

  @override
  List<Object> get props => [];
}

class FetchFilmTopRated extends FilmTopRatedEvent {}