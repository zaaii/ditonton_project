part of 'film_populer_bloc.dart';

abstract class FilmPopulerEvent extends Equatable {
  const FilmPopulerEvent();

  @override
  List<Object> get props => [];
}

class FetchFilmPopuler extends FilmPopulerEvent {}