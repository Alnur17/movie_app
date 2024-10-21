import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../screens/movie_details_screen.dart';
import '../services/api_service.dart';

class MovieCarousel extends StatelessWidget {
  final int selectedIndex;

  const MovieCarousel({super.key, required this.selectedIndex});

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
          return CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
            ),
            items: movies.map((movie) {
              return GestureDetector(
                onTap: () {
                  Get.to(MovieDetailsScreen(movie: movie));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    ApiService().getImageUrl(movie.backdropPath),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
