import 'package:flutter/cupertino.dart';

class DescriptionText extends StatelessWidget {

  final String text;
  final TextAlign? textAlign;
  final Alignment? alignment;
  final Color? color;

  const DescriptionText({super.key, required this.text, this.textAlign, this.alignment, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.center,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
            color: color ?? const Color.fromRGBO(27, 27, 27, 0.6),
            fontFamily: 'Rubik',
            fontSize: 16
        ),
      ),
    );
  }
}