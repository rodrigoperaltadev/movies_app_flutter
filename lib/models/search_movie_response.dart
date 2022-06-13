import 'dart:convert';

import 'package:movies_app/models/models.dart';

class SearchMovieResponse {
  SearchMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalMovies,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalMovies;

  factory SearchMovieResponse.fromJson(String str) =>
      SearchMovieResponse.fromMap(json.decode(str));

  factory SearchMovieResponse.fromMap(Map<String, dynamic> json) =>
      SearchMovieResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalMovies: json["total_results"],
      );
}
