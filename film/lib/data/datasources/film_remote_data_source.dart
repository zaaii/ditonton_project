import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:core/core.dart';
import 'package:film/data/models/film_detail_response.dart';
import 'package:film/data/models/film_model.dart';
import 'package:film/data/models/film_response.dart';

abstract class FilmRemoteDataSource {
  Future<List<FilmModel>> getNowPlayingFilm();
  Future<List<FilmModel>> getFilmPopuler();
  Future<List<FilmModel>> getFilmTopRated();
  Future<FilmDetailResponse> getDetailFilm(int id);
  Future<List<FilmModel>> getRecommendationsFilm(int id);
  Future<List<FilmModel>> searchFilm(String query);
}

class FilmRemoteDataSourceImpl implements FilmRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  FilmRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FilmModel>> getNowPlayingFilm() async {
    final response = await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

    if (response.statusCode == 200) {
      return FilmResponse.fromJson(json.decode(response.body)).filmList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FilmDetailResponse> getDetailFilm(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return FilmDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<FilmModel>> getRecommendationsFilm(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return FilmResponse.fromJson(json.decode(response.body)).filmList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<FilmModel>> getFilmPopuler() async {
    final response = await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return FilmResponse.fromJson(json.decode(response.body)).filmList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<FilmModel>> getFilmTopRated() async {
    final response = await client.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return FilmResponse.fromJson(json.decode(response.body)).filmList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<FilmModel>> searchFilm(String query) async {
    final response = await client.get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return FilmResponse.fromJson(json.decode(response.body)).filmList;
    } else {
      throw ServerException();
    }
  }
}
