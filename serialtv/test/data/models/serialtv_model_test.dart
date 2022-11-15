import 'package:flutter_test/flutter_test.dart';
import 'package:serialtv/data/models/serialtv_model.dart';
import 'package:serialtv/domain/entities/serialtv.dart';

void main() {
  final tSerialTvModel = SerialTvModel(
    backdropPath: 'backdropPath',
    genreIds: [1],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSerialTv= SerialTv(
    backdropPath: 'backdropPath',
    genreIds: [1],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Serial Tv entity', () async {
    final result = tSerialTvModel.toEntity();
    expect(result, tSerialTv);
  });
}