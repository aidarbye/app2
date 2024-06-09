import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  final String text;
  final Color? buttonBackground;
  final Function? onPressed;

  const PrimaryButton({super.key, required this.text, this.onPressed, this.buttonBackground});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPressed?.call(),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(249, 126, 134, 1),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Container(
            width: double.infinity,
            height: 48,
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        )
    );
  }
}