import 'package:equatable/equatable.dart';
import 'package:film/data/models/film_model.dart';

class FilmResponse extends Equatable {
  final List<FilmModel> filmList;

  FilmResponse({required this.filmList});

  factory FilmResponse.fromJson(Map<String, dynamic> json) => FilmResponse(
    filmList: List<FilmModel>.from((json["results"] as List)
        .map((x) => FilmModel.fromJson(x))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(filmList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [filmList];
}
