import 'dart:convert';
import 'models.dart';

class LoginResponse {
    bool ok;
    User user;
    String token;

    LoginResponse({
        required this.ok,
        required this.user,
        required this.token,
    });

    factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        user: User.fromMap(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "user": user.toMap(),
        "token": token,
    };
}