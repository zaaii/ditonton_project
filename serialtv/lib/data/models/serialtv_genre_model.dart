import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv_genre.dart';

class SerialTvGenreModel extends Equatable {
  SerialTvGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory SerialTvGenreModel.fromJson(Map<String, dynamic> json) => SerialTvGenreModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  SerialTvGenre toEntity() {
    return SerialTvGenre(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
