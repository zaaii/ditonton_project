part of 'film_detail_bloc.dart';

abstract class DetailFilmEvent extends Equatable {
  const DetailFilmEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailFilm extends DetailFilmEvent {
  final int id;

  const FetchDetailFilm(this.id);

  @override
  List<Object> get props => [id];
}