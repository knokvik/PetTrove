import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pettrove/models/blog.dart';

class BlogRepository {

  Future<List<Blog>> fetchBlogs() async {
    try {
      final url = Uri.parse('https://clever-shape-81254.pktriot.net/api/blogs'); // Replace with your actual blog API endpoint.
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> blogJson = json.decode(response.body);
        print(response.body);
        return blogJson.map((json) => Blog.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      throw Exception('Error fetching blogs: $e');
    }
  }

    Future<Blog> updateBlog(Blog blog) async {
    final response = await http.post(
      Uri.parse('https://clever-shape-81254.pktriot.net/upload-blog'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(blog.toJson()),
    );

    if (response.statusCode == 200) {
      print("Updated");
      return blog;
    } else {
      throw Exception('Failed to upload blog');
    }
  }
}
