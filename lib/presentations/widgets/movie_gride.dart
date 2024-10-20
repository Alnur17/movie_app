import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/api_constants.dart';
import '../models/movie_models.dart';
import '../screens/movie_details_screen.dart';
import '../services/movie_service.dart';

class MovieGrid extends StatefulWidget {
  @override
  _MovieGridState createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  late Future<MovieModel?> allMovies;

  @override
  void initState() {
    super.initState();
    allMovies = MovieService.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieModel?>(
      future: allMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
          return const Center(child: Text('No movies available.'));
        }

        return GridView.builder(
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: snapshot.data!.results.length,
          itemBuilder: (context, index) {
            final movie = snapshot.data!.results[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => MovieDetailsScreen(movie: movie));
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${ApiUrls.imageBaseUrl}${movie.posterPath}'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        );

      },
    );
  }
}
