import 'package:equatable/equatable.dart';

class GenreFilm extends Equatable {
  GenreFilm({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
