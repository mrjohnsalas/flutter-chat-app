import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String question;
  final String linkText;
  final String route;

  const Labels({super.key, required this.route, required this.question, required this.linkText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(question, style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
          const SizedBox(height: 10),
          GestureDetector(
            child: Text(linkText, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, route);
            }
          )
        ],
      )
    );
  }
}