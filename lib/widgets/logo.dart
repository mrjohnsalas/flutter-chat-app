import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final String title;
  final AssetImage image;

  const Logo({super.key, required this.title, this.image = const AssetImage('assets/images/tag-logo.png')});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Image(image: image),
            const SizedBox(height: 20),
            Text(title, style: const TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}