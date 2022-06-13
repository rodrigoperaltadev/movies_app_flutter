import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '43830c60bb2824f1ac4e813957c23817';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int popularPage = 0;
  bool isFetchingPopular = false;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing', 1);

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    if (isFetchingPopular) return;
    isFetchingPopular = true;
    popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', popularPage);
    final popularMoviesResponse = PopularMoviesResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularMoviesResponse.results];
    notifyListeners();
    isFetchingPopular = false;
  }

  Future<String> _getJsonData(String endpoint, [int? page]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '${page ?? 1}',
    });

    final response = await http.get(url);
    return response.body;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (!movieCast.containsKey(movieId)) {
      final jsonData = await _getJsonData('3/movie/$movieId/credits');
      final creditsResponse = CreditsResponse.fromJson(jsonData);
      movieCast[movieId] = creditsResponse.cast;
    }
    return movieCast[movieId]!;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchMovieResponse.fromJson(response.body);
    return searchResponse.results;
  }
}
