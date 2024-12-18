import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sexeducation/models/post_model.dart';

abstract class SearchService {
  static Future<List<PostModel>> search(String query) async {
    // Load the posts.json file
    final String response = await rootBundle.loadString('data/posts.json');
    final List<dynamic> postsJson = json.decode(response);

    // Convert the JSON data to a list of PostModel objects
    final posts = postsJson.map((post) {
      return PostModel.fromJson(post);
    }).toList();

    // Filter posts by title or description
    final filteredPosts = posts.where((post) {
      final titleLower = post.title!.toLowerCase();
      final descriptionLower = post.description!.toLowerCase();
      final queryLower = query.toLowerCase();

      return titleLower.contains(queryLower) ||
          descriptionLower.contains(queryLower);
    }).toList();

    return filteredPosts;
  }
}
