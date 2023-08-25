import '../global/environment.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';


class UserService {

  Future<List<User>> getUsers() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/users'), 
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final usersResponse = UsersResponse.fromJson(resp.body);
      return usersResponse.users;
    } catch (e) {
      return [];
    }
  }
}