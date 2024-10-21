class ApiUrls {
  static const String apiKey = 'ecdfb0f6754c4177d5f9ec2c4fa7a9f2';
  static const String apiToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlY2RmYjBmNjc1NGM0MTc3ZDVmOWVjMmM0ZmE3YTlmMiIsIm5iZiI6MTcyOTQ4MzYwNi4wNTYzNDUsInN1YiI6IjY3MTQ3ZjY3OTlmMjJmMzI2YWFkNTFkMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mVuFp0FdMxb8iauaWVDbMpNBvLVh4zwn4Psx6tSGHdo';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2';

  // Endpoints
  static const String allMovies = '$baseUrl/discover/movie?api_key=$apiKey';
  static const String popularMovies = '$baseUrl/movie/popular?api_key=$apiKey';
  static const String trendingMovies = '$baseUrl/trending/movie/day?api_key=$apiKey';
  static const String searchMovies = '$baseUrl/search/movie?api_key=$apiKey';

}
