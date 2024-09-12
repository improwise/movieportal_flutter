import 'package:flutter/foundation.dart';
import 'package:movieportal_flutter/models/movie_details.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';

class MovieProvider with ChangeNotifier {
  final TMDBService _tmdbService = TMDBService();
  List<Movie> _movies = [];
  bool _isLoading = false;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> fetchPopularMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _movies = await _tmdbService.getPopularMovies();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching popular movies: $e');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _movies = await _tmdbService.searchMovies(query);
    } catch (e) {
      if (kDebugMode) {
        print('Error searching movies: $e');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTopRatedMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _movies = await _tmdbService.getTopRatedMovies();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching top rated movies: $e');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    return await _tmdbService.getMovieDetails(movieId);
  }

  void clearMovies() {
    _movies = [];
    notifyListeners();
  }
}
