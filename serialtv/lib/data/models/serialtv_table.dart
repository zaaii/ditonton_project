import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';

class SerialTvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  SerialTvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory SerialTvTable.fromEntity(DetailSerialTv serialtv) => SerialTvTable(
    id: serialtv.id,
    name: serialtv.name,
    posterPath: serialtv.posterPath,
    overview: serialtv.overview,
  );

  factory SerialTvTable.fromMap(Map<String, dynamic> map) => SerialTvTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  SerialTv toEntity() => SerialTv.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
