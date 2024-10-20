import 'package:flutter/material.dart';
import '../constants/api_constants.dart';
import '../models/movie_models.dart';
import '../constants/app_text_style.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Result movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.originalTitle, style: TextStyles.titleStyle),
                const SizedBox(height: 10),
                Image.network('${ApiUrls.imageBaseUrl}${movie.backdropPath}',fit: BoxFit.contain,),
                const SizedBox(height: 10),
                Text(movie.overview, style: TextStyles.bodyStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
