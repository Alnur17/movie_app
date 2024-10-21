import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../screens/movie_details_screen.dart';
import '../services/api_service.dart';

class MoviesGrid extends StatelessWidget {
  final int selectedIndex;

  const MoviesGrid({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    Future<List<MovieModel>> selectedMoviesFuture;
    switch (selectedIndex) {
      case 0:
        selectedMoviesFuture = ApiService().fetchAllMovies();
        break;
      case 1:
        selectedMoviesFuture = ApiService().fetchPopularMovies();
        break;
      case 2:
        selectedMoviesFuture = ApiService().fetchTrendingMovies();
        break;
      default:
        selectedMoviesFuture = ApiService().fetchAllMovies();
    }

    return FutureBuilder<List<MovieModel>>(
      future: selectedMoviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final movies = snapshot.data!;
          return GridView.builder(
            primary: false,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Get.to(MovieDetailsScreen(movie: movie));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    ApiService().getImageUrl(movie.posterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
