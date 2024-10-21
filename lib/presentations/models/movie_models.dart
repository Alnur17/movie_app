class Result {
  final bool adult;
  final String backdropPath;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"] ?? '',
      id: json["id"] ?? 0,
      originalLanguage: json["original_language"] ?? '',
      originalTitle: json["original_title"] ?? '',
      overview: json["overview"] ?? '',
      popularity: (json["popularity"] as num).toDouble(),
      posterPath: json["poster_path"] ?? '',
      releaseDate: _parseReleaseDate(json["release_date"]),
      title: json["title"] ?? '',
      video: json["video"] ?? false,
      voteAverage: (json["vote_average"] as num).toDouble(),
      voteCount: json["vote_count"] ?? 0,
    );
  }

  static DateTime _parseReleaseDate(String? releaseDateStr) {
    if (releaseDateStr == null || releaseDateStr.isEmpty) {
      return DateTime.now();
    }
    try {
      return DateTime.parse(releaseDateStr);
    } catch (e) {
      print('Error parsing date: $releaseDateStr - ${e.toString()}');
      return DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "backdrop_path": backdropPath,
      "id": id,
      "original_language": originalLanguage,
      "original_title": originalTitle,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "release_date": releaseDate.toIso8601String(),
      "title": title,
      "video": video,
      "vote_average": voteAverage,
      "vote_count": voteCount,
    };
  }
}
