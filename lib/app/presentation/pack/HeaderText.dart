import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {

  final String text;
  final double? size;
  final TextAlign? textAlign;
  final Alignment? alignment;

  const HeaderText({super.key, required this.text, this.size, this.textAlign, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.center,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
            color: const Color.fromRGBO(27, 27, 27, 1),
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w600,
            fontSize: size ?? 24
        ),
      ),
    );
  }
}