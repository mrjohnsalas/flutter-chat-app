import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {

  final String text;
  final Function()? onPressed;

  const BlueButton({
    super.key, required this.text, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2, 
        backgroundColor: Colors.blue,
        shape: const StadiumBorder()
      ),
      onPressed: onPressed, 
      child: Container(
        width: double.infinity,
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18))
        ),
      )
    );
  }
}