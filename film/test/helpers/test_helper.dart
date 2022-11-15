import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:film/data/datasources/db/film_database_helper.dart';
import 'package:film/data/datasources/film_local_data_source.dart';
import 'package:film/data/datasources/film_remote_data_source.dart';
import 'package:film/domain/repositories/film_repository.dart';

@GenerateMocks([
  FilmRepository,
  FilmRemoteDataSource,
  FilmLocalDataSource,
  FilmDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
