class Movie {
  final int id;
  final String title;
  final String posterPath;
  final List<String> genreIds;
  final String? releaseDate;
  final double? rating;

  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.genreIds,
    this.releaseDate,
    this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((id) => id.toString())
          .toList(),
      releaseDate: json['release_date'],
      rating: json['vote_average']?.toDouble(),
    );
  }
}
