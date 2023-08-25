import 'package:chat_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global/environment.dart';
import 'auth_service.dart';

class ChatService with ChangeNotifier {
  User? userTo;

  Future<List<Message>> getChat(String userId) async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/messages/$userId'), 
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final messagesResponse = MessagesResponse.fromJson(resp.body);
      return messagesResponse.messages;
    } catch (e) {
      return [];
    }
  }
}