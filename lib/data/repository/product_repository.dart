import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pettrove/models/products.dart';

  class ProductRepository {
    // Simulated API call (replace with actual HTTP request)
    Future<List<Product>> fetchProducts() async {
      try {
        final url = Uri.parse('https://clever-shape-81254.pktriot.net/api/products');

        final response = await http.get(url);
        
        if (response.statusCode == 200) {
          final List<dynamic> productJson = json.decode(response.body);
          return productJson.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load products');
        }
      } catch (e) {
        throw Exception('Error fetching products: $e');
      }
    }
  }
