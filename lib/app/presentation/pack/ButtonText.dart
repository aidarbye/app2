import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {

  final String text;
  final Function? onPressed;

  const ButtonText({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPressed?.call(),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: Text(
            text,
            style: const TextStyle(
                color: Color.fromRGBO(249, 126, 134, 1),
                fontFamily: 'Rubik',
                fontSize: 16
            ),
          ),
        ),
    );
  }

}