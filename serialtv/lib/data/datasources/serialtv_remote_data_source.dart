import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:core/core.dart';
import 'package:serialtv/data/models/serialtv_detail_response.dart';
import 'package:serialtv/data/models/serialtv_model.dart';
import 'package:serialtv/data/models/serialtv_response.dart';

abstract class SerialTvRemoteDataSource {
  Future<SerialTvDetailResponse> getDetailSerialTv(int id);
  Future<List<SerialTvModel>> getRecommendationsSerialTv(int id);
  Future<List<SerialTvModel>> getNowPlayingSerialTv();
  Future<List<SerialTvModel>> getSerialTvPopuler();
  Future<List<SerialTvModel>> getSerialTvTopRated();
  Future<List<SerialTvModel>> searchSerialTv(String query);
}

class SerialTvRemoteDataSourceImpl implements SerialTvRemoteDataSource {
  static const api_Key = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const base_Url = 'https://api.themoviedb.org/3';

  final http.Client client;

  SerialTvRemoteDataSourceImpl({required this.client});

  @override
  Future<SerialTvDetailResponse> getDetailSerialTv(int id) async {
    final response = await client
        .get(Uri.parse('$base_Url/tv/$id?$api_Key'));
    if (response.statusCode == 200) {
      return SerialTvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTvModel>> getNowPlayingSerialTv() async {
    final response = await client
        .get(Uri.parse('$base_Url/tv/airing_today?$api_Key'));
    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTvModel>> getRecommendationsSerialTv(int id) async {
    final response = await client
        .get(Uri.parse('$base_Url/tv/$id/recommendations?$api_Key'));
    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTvModel>> getSerialTvPopuler() async {
    final response = await client
        .get(Uri.parse('$base_Url/tv/popular?$api_Key'));
    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTvModel>> getSerialTvTopRated() async {
    final response = await client
        .get(Uri.parse('$base_Url/tv/top_rated?$api_Key'));
    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTvModel>> searchSerialTv(String query) async {
    final response = await client
        .get(Uri.parse('$base_Url/search/tv?$api_Key&query=$query'));
    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }
}
