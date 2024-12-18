import 'package:flutter/material.dart';
import 'package:sexeducation/data/sexeducation_api_data_source.dart';
import 'package:sexeducation/models/user_model.dart';
import 'package:sexeducation/services/notifications/notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AuthenticationService {
  static Future<void> login({
    required String email,
    required String password,
  }) async {
    // Check if the email and password are valid
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Invalid email or password');
    }

    // Load the Users.json file
    final String response = await rootBundle.loadString('data/users.json');
    final List<dynamic> users = json.decode(response);

    // Check if the email and password match any user in the JSON file
    final user = users.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => null,
    );

    if (user == null) {
      throw Exception('Invalid email or password');
    }

    debugPrint('users: $user');

    // Save the user information in the local storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', user['token']);
  }

  static Future<UserModel> register({
    required String email,
    required String username,
    required String password,
  }) async {
    // Check if the email and password are valid
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      throw Exception('Invalid email, username or password');
    }

    // We create a request object to send to the API
    final request = {
      'email': email,
      'username': username,
      'password': password,
    };

    // We send the request to the API and get the response
    final response = await EcoGestApiDataSource.post('/register', request,
        error: 'Failed to register');

    if (response['message'] != null) {
      throw Exception(response['message']);
    }
    // We get the token from the response
    String token;
    try {
      token = response['access_token'];
    } catch (e) {
      // If the token is not in the response, throw an error
      throw Exception('Failed to parse token');
    }

    // We save the token in the local storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);

    return UserModel.fromJson(response);
  }

  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<String?> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    } catch (e) {
      return null;
    }
  }

  static Future<void> resetPassword({
    required String email,
  }) async {
    // Check if the email is valid
    if (email.isEmpty) {
      throw Exception('Invalid email or password');
    }

    // We create a request object to send to the API
    final request = {
      'email': email,
    };

    // We send the request to the API and get the response
    final response = await EcoGestApiDataSource.post(
        '/request-reset-password', request,
        error: 'Failed to send mail to reset password');
    return response;
  }
}
