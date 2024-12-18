import 'package:sexeducation/data/sexeducation_api_data_source.dart';
import 'package:sexeducation/models/post_model.dart';
import 'package:sexeducation/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class PostService {
  Future<List<PostModel>> getPosts() async {
    // Load the posts.json file
    final String response = await rootBundle.loadString('data/posts.json');
    final List<dynamic> postsJson = json.decode(response);

    // Convert the JSON data to a list of PostModel objects
    final posts = postsJson.map((post) {
      return PostModel.fromJson(post);
    }).toList();

    return posts;
  }

  Future<PostModel> getOnePost(int postId) async {
    final String? token = await AuthenticationService.getToken();
    final post = await EcoGestApiDataSource.get('/posts/$postId', token: token);
    return PostModel.fromJson(post);
  }

  Future<PostModel> createPost(PostModel postModel) async {
    final String? token = await AuthenticationService.getToken();
    final body = postModel.toJson();

    await EcoGestApiDataSource.post('/posts', body, token: token);

    return postModel;
  }

  Future<PostModel> updatePost(PostModel postModel) async {
    final String? token = await AuthenticationService.getToken();

    final body = postModel.toJson();

    final result = await EcoGestApiDataSource.patch(
        '/posts/${postModel.id}', body,
        token: token);

    if (result['error'] != null) {
      throw Exception(result['error']);
    }

    return postModel;
  }

  static Future<void> deletePost(int postId) async {
    final String? token = await AuthenticationService.getToken();

    await EcoGestApiDataSource.delete(
      '/posts/$postId',
      {},
      token: token,
    );
  }

  Future<void> submitReport(int postId, String result) async {
    try {
      final String? token = await AuthenticationService.getToken();

      getOnePost(postId).then((PostModel post) async {
        final Map<String, dynamic> requestBody = {
          'ID': post.id,
          'title': post.title,
          'authorID': post.authorId,
          'result': result,
          'content': post.description,
        };

        await EcoGestApiDataSource.post('/submit-report', requestBody,
            token: token);
      });
    } catch (error) {
      throw Exception('Échec du signalement');
    }
  }
}
