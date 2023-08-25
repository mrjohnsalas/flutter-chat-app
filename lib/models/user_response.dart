import 'dart:convert';

import 'models.dart';

class UsersResponse {
    bool ok;
    List<User> users;

    UsersResponse({
        required this.ok,
        required this.users,
    });

    factory UsersResponse.fromJson(String str) => UsersResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
        ok: json["ok"],
        users: List<User>.from(json["users"].map((x) => User.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toMap())),
    };
}