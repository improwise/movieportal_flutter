import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_grid.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<MovieProvider>(context, listen: false)
        .fetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          return MovieGrid(
            movies: movieProvider.movies,
            isLoading: movieProvider.isLoading,
          );
        },
      ),
    );
  }
}
