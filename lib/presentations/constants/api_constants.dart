class ApiUrls {
  static const String apiKey = '4b6ea4c946172393366acfbee793bfb7';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2';

  // Endpoints
  static const String popularMovies = '$baseUrl/movie/popular?api_key=$apiKey';
  static const String searchMovies = '$baseUrl/discover/movie?api_key=$apiKey&query=';
  static const String allMovies = '$baseUrl/discover/movie';
}
