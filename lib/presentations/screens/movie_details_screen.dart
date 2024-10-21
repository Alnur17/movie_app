import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(movie.title, style: TextStyles.titleStyle),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(ApiService().getImageUrl(movie.backdropPath)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(movie.title, style: TextStyles.titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Release Date: ${movie.releaseDate.toLocal().toString().split(' ')[0]}',
                style: TextStyles.subtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.overview,
                style: TextStyles.overviewStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  Text(
                      'Rating: ${movie.voteAverage} (${movie.voteCount} votes)',
                      style: TextStyles.ratingStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
