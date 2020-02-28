import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'package:movies_app/src/models/movie.dart';


class MoviesProvider {

  String _apiKey = '';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Movie>> _processResponse(Uri url) async {

    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getMovies() async {

    final url = Uri.https(_url,'3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _language
    });

    /*final response =  await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);
    //print( movies.items[1].title );

    return movies.items;*/
    return await _processResponse(url);

  }

  Future<List<Movie>> getPopularMovies() async {
    final url = Uri.https(_url,'3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language
    });

    /*final response =  await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;*/

    return await _processResponse(url);

  }

}