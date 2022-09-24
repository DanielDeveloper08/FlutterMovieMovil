import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_project_cinema/models/product.dart';
import 'dart:convert';


class ProductService {
  Future<List<Product>> fetchMovies() async {
    List<Product> products = [];
    try {
      Uri uri =
          Uri.parse('https://cinemaws-production.up.railway.app/api/v1/products');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        dynamic results = await jsonDecode(response.body);
        for(int i=0; i<results.length;i++){
          products.add(Product.fromJson(results[i]));
        }
        print(jsonEncode(products));
      } else {
        throw Exception('Connection Error');
      }
    } catch (error) {
      print(error.toString());
      return products;
    }
    return products;
  }

  Future<Product?> saveMovie(String filepath, String movieData) async {
    Product? movie = null;
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://cinemaws-production.up.railway.app/api/v1/products'));
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

  Future<List<Type>> fetchTypes() async {
    
    List<Type> genders=[];
    try {
      Uri uri =
          Uri.parse('https://cinemaws-production.up.railway.app/api/v1/types');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        dynamic results = await jsonDecode(response.body);
        for(int i=0; i<results.length;i++){
          genders.add(Type(id: results[i]['gender_id'].toString(),name:results[i]['gender_name']));
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
}
class Type{
String id;
String name;
Type({
 required this.id,
 required this.name 
}); 
}