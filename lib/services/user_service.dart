import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sexeducation/data/sexeducation_api_data_source.dart';
import 'package:sexeducation/models/user_model.dart';
import 'package:sexeducation/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<UserModel> getCurrentUser() async {
    final String? token = await AuthenticationService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    // Load the Users.json file
    final String response = await rootBundle.loadString('data/users.json');
    final List<dynamic> users = json.decode(response);

    // Find the user with the matching token
    final user = users.firstWhere(
      (user) => user['token'] == token,
      orElse: () => null,
    );

    if (user == null) {
      throw Exception('User not found');
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', '${user['id']}');

    return UserModel.fromJson(user);
  }

  static Future<UserModel> updateUserAccount(UserModel user) async {
    final String? token = await AuthenticationService.getToken();

    final body = user.toJson();

    await EcoGestApiDataSource.patch('/me', body, token: token);

    return user;
  }

  static Future<UserModel> getUser(int userId) async {
    final String? token = await AuthenticationService.getToken();

    var responseMap =
        await EcoGestApiDataSource.get('/users/$userId', token: token);

    return UserModel.fromJson(responseMap);
  }

  static Future<void> submitReport(int userId, String result) async {
    try {
      final String? token = await AuthenticationService.getToken();

      final Map<String, dynamic> requestBody = {
        'ID': userId,
        'title': 'profil',
        'authorID': userId,
        'result': result,
        'content': 'Profil de l\'utilisateur signalé',
      };
      await EcoGestApiDataSource.post('/submit-report', requestBody,
          token: token);
    } catch (error) {
      throw Exception('Échec du signalement');
    }
  }

  static Future<void> changePassword(
      {required String oldPassword,
      required String password,
      required String passwordRepeated}) async {
    try {
      final String? token = await AuthenticationService.getToken();
      final Map<String, dynamic> requestBody = {
        'old_password': oldPassword,
        'new_password': password,
        'confirm_password': passwordRepeated,
      };

      await EcoGestApiDataSource.post('/change-password', requestBody,
          token: token);
    } catch (error) {
      throw Exception('Échec du changement de mot de passe');
    }
  }
}
