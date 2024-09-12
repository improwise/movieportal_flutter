import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_details.dart';
import '../providers/movie_provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieDetails> _movieDetailsFuture;

  @override
  void initState() {
    super.initState();
    _movieDetailsFuture = Provider.of<MovieProvider>(context, listen: false)
        .getMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: FutureBuilder<MovieDetails>(
        future: _movieDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Release Date: ${movie.releaseDate ?? 'Unknown'}',
                          style: textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Genres: ${movie.genres.join(', ')}',
                          style: textTheme.bodyLarge,
                        ),
                        if (movie.rating != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                '${movie.rating!.toStringAsFixed(1)}/10',
                                style: textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),
                        Text(
                          'Overview:',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(movie.overview ?? 'No overview available.'),
                        const SizedBox(height: 16),
                        Text(
                          'Cast:',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(movie.actors.join(', ')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
