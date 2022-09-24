import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
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
  Future<List<Classification>> fetchCategories() async {
    List<Classification> categories=[];
    try {
      Uri uri =
          Uri.parse('https://cinemaws-production.up.railway.app/api/v1/categories');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        dynamic results = await jsonDecode(response.body);
        for(int i=0; i<results.length;i++){
          Classification classification =Classification(id:results[i]['category_id'].toString(),name:results[i]['name']);
          categories.add(classification);
        }
        
      } else {
        throw Exception('Connection Error');
      }
    } catch (error) {
      print(error.toString());
      return categories;
    }
    return categories;
  }
  Future<List<Gender>> fetchGenders() async {
    
    List<Gender> genders=[];
    try {
      Uri uri =
          Uri.parse('https://cinemaws-production.up.railway.app/api/v1/genders');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        dynamic results = await jsonDecode(response.body);
        for(int i=0; i<results.length;i++){
          genders.add(Gender(id: results[i]['gender_id'].toString(),name:results[i]['gender_name']));
        }
        
      } else {
        throw Exception('Connection Error');
      }
    } catch (error) {
      print(error.toString());
      return genders;
    }
    return genders;
  }
  Future<Movie?> saveMovie(String filepath, String movieData) async {
    Movie? movie = null;
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://cinemaws-production.up.railway.app/api/v1/movies'));
      request.files.add(
      http.MultipartFile(
        'image',
        File(filepath).readAsBytes().asStream(),
        File(filepath).lengthSync(),
        filename: filepath.split("/").last
      )
      );
      request.fields.addAll({"data":movieData});
      var response = await request.send();
      print('hola');
      if (response.statusCode == 200) {
        print(jsonEncode(response).toString());
        print(movieData);
        print(response.statusCode);//dynamic results = await jsonDecode(response.body);
      } else {
        throw Exception('Connection Error');
      }
    } catch (error) {
      print(error.toString());
      return movie;
    }
    return movie;
  }
}
class Gender{
String id;
String name;
Gender({
 required this.id,
 required this.name 
}); 
}
class Classification{
String id;
String name;
Classification({
 required this.id,
 required this.name 
}); 
}