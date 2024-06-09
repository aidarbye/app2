import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {

  final String text;
  final Color color;
  final double size;

  const SimpleText({super.key, required this.text, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.normal
      ),
    );
  }
}