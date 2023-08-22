import 'dart:convert';

class User {
    String firstName;
    String lastName;
    String email;
    bool online;
    String uid;

    get fullName {
      return '$firstName $lastName';
    }

    User({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.online,
        required this.uid,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
    );

    Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "online": online,
        "uid": uid,
    };
}
