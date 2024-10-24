import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/movie_model.dart';

class ApiService {
  final String _apiToken = ApiUrls.apiToken;

  // Fetch all movies
  Future<List<MovieModel>> fetchAllMovies() async {
    final response = await http.get(
      Uri.parse(ApiUrls.allMovies),
      headers: {'Authorization': 'Bearer $_apiToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load all movies');
    }
  }

  // Fetch popular movies
  Future<List<MovieModel>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse(ApiUrls.popularMovies),
      headers: {'Authorization': 'Bearer $_apiToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  // Fetch trending movies
  Future<List<MovieModel>> fetchTrendingMovies() async {
    final response = await http.get(
      Uri.parse(ApiUrls.trendingMovies),
      headers: {'Authorization': 'Bearer $_apiToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  // Search movies by query
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('${ApiUrls.searchMovies}&query=${Uri.encodeComponent(query)}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Get the full image URL
  String getImageUrl(String posterPath) {
    return '${ApiUrls.imageBaseUrl}$posterPath';
  }
}
