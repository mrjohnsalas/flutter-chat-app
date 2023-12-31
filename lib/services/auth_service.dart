import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {

  User? user;
  bool _authenticating = false;

  // Create storage
  final _storage = FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  // Getters of token
  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token ?? '';
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }
  
  Future<bool> login(String email, String password) async {

    authenticating = true;

    final data = {
      'email': email.trim(),
      'password': password.trim()
    };

    final resp = await http.post(Uri.parse('${ Environment.apiUrl }/login'), 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    authenticating = false;

    if(resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String firstName, String lastName, String email, String password) async {
    authenticating = true;

    final data = {
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'email': email.trim(),
      'password': password.trim()
    };

    final resp = await http.post(Uri.parse('${ Environment.apiUrl }/login/new'), 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    
    authenticating = false;

    if(resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final resp = await http.get(Uri.parse('${ Environment.apiUrl }/login/renew'), 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      }
    );

    if(resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}