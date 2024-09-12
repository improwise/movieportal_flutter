import 'movie.dart';

class MovieDetails extends Movie {
  final String? overview;
  final List<String> genres;
  final List<String> actors;

  const MovieDetails({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.genreIds,
    required super.releaseDate,
    required super.rating,
    required this.overview,
    required this.genres,
    required this.actors,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((id) => id.toString())
              .toList() ??
          [],
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      releaseDate: json['release_date'],
      rating: json['vote_average']?.toDouble(),
      overview: json['overview'],
      actors: (json['credits']['cast'] as List<dynamic>?)
              ?.take(5)
              .map((actor) => actor['name'] as String)
              .toList() ??
          [],
    );
  }
}
