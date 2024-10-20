
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../models/movie_models.dart';

class MovieService {
  static Future<MovieModel?> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('${ApiUrls.searchMovies}$query'),  // search URL with the query appended
    );

    if (response.statusCode == 200) {
      return MovieModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load search results');
    }
  }

  static Future<MovieModel?> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse(ApiUrls.popularMovies),  // directly use the popularMovies URL
    );

    if (response.statusCode == 200) {
      return MovieModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

}
