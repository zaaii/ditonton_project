import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:serialtv/data/datasources/db/serialtv_database_helper.dart';
import 'package:serialtv/data/datasources/serialtv_local_data_source.dart';
import 'package:serialtv/data/datasources/serialtv_remote_data_source.dart';
import 'package:serialtv/domain/repositories/serialtv_repository.dart';

@GenerateMocks([
  SerialTvRepository,
  SerialTvRemoteDataSource,
  SerialTvLocalDataSource,
  SerialTvDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}