import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_status/http_status.dart';
import 'package:movieportal_flutter/models/movie_details.dart';
import '../models/movie.dart';

class TMDBService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static final String _apiKey = dotenv.env['TMDB_API_KEY']!;

  Future<List<Movie>> getPopularMovies() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));
    return _parseMovies(response);
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'));
    return _parseMovies(response);
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey'));
    return _parseMovies(response);
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/movie/$movieId?api_key=$_apiKey&append_to_response=credits'));
    if (response.statusCode == HttpStatusCode.ok) {
      final json = jsonDecode(response.body);
      return MovieDetails.fromJson(json);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  List<Movie> _parseMovies(http.Response response) {
    if (response.statusCode == HttpStatusCode.ok) {
      final json = jsonDecode(response.body);
      return (json['results'] as List)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
