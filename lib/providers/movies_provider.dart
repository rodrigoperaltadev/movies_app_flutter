import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '43830c60bb2824f1ac4e813957c23817';
  final String _language = 'es-ES';

  MoviesProvider() {
    print('MoviesProvider initialized');

    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    final url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);
    print(response.body);
  }
}
