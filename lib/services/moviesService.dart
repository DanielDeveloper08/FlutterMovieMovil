import 'package:http/http.dart' as http;
import 'package:flutter_project_cinema/models/movie.dart';
import 'dart:convert';

class MoviesService {
  Future<List<Movie>> fetchMovies() async {
    List<Movie> movies = [];
    try {
      Uri uri =
          Uri.parse('https://cinemaws-production.up.railway.app/api/v1/movies');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        dynamic results = await jsonDecode(response.body);
        for(int i=0; i<results.length;i++){
          movies.add(Movie.fromJson(results[i]));
        }
        
      } else {
        throw Exception('Connection Error');
      }
    } catch (error) {
      print(error.toString());
      return movies;
    }
    return movies;
  }
}
