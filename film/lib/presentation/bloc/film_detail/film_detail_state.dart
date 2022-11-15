part of 'film_detail_bloc.dart';

abstract class DetailFilmState extends Equatable {
  const DetailFilmState();

  @override
  List<Object> get props => [];
}

class DetailFilmLoading extends DetailFilmState {}

class DetailFilmEmpty extends DetailFilmState {}

class DetailFilmError extends DetailFilmState {
  final String message;
  const DetailFilmError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailFilmHasData extends DetailFilmState {
  final DetailFilm result;
  const DetailFilmHasData(this.result);

  @override
  List<Object> get props => [result];
}