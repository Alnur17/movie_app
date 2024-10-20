import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/api_constants.dart';
import '../models/movie_models.dart';
import '../screens/movie_details_screen.dart';
import '../services/movie_service.dart';

class MovieCarousel extends StatefulWidget {
  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  late Future<MovieModel?> popularMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = MovieService.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieModel?>(
      future: popularMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
          return const Center(child: Text('No movies available.'));
        }

        List<Result> movies = snapshot.data!.results;

        return CarouselSlider.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => MovieDetailsScreen(movie: movie));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${ApiUrls.imageBaseUrl}${movie.backdropPath}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
          ),
        );

      },
    );
  }
}
