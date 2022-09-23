import 'package:http/http.dart' as http;
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
}