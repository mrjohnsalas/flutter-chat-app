import 'dart:convert';
import 'package:chat_app/models/message.dart';

class MessagesResponse {
    bool ok;
    List<Message> messages;

    MessagesResponse({
        required this.ok,
        required this.messages,
    });

    factory MessagesResponse.fromJson(String str) => MessagesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MessagesResponse.fromMap(Map<String, dynamic> json) => MessagesResponse(
        ok: json["ok"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toMap())),
    };
}