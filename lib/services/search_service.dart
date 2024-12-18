import 'package:sexeducation/data/sexeducation_api_data_source.dart';
import 'package:sexeducation/models/post_model.dart';
import 'package:sexeducation/models/user_model.dart';
import 'package:sexeducation/services/authentication_service.dart';

abstract class SearchService {
  static Future<List<PostModel>> searchPosts(String query) async {
    final String? token = await AuthenticationService.getToken();
    final Map<String, dynamic> responseMap =
        await EcoGestApiDataSource.get('/search/$query', token: token);

    if (responseMap.containsKey('posts')) {
      // Data key contains the list of 30 posts
      final List<dynamic> responseData = responseMap['posts'];
      final List<PostModel> posts = responseData.map((post) {
        return PostModel.fromJson(post);
      }).toList();
      return posts;
    } else {
      return [];
    }
  }

  static Future<List<UserModel>> searchUsers(String query) async {
    final String? token = await AuthenticationService.getToken();
    final Map<String, dynamic> responseMap =
        await EcoGestApiDataSource.get('/search/$query', token: token);

    if (responseMap.containsKey('users')) {
      // Data key contains the list of 30 posts
      final List<dynamic> responseData = responseMap['users'];
      final List<UserModel> users = responseData.map((user) {
        return UserModel.fromJson(user);
      }).toList();
      return users;
    } else {
      return [];
    }
  }
}
