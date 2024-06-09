import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CodeWidget extends StatelessWidget {

  final TextEditingController controller;

  const CodeWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [MaskTextInputFormatter(
          mask: '####',
          filter: { "#": RegExp(r'[0-9]') },
          type: MaskAutoCompletionType.lazy
      )],
      style: const TextStyle(
          color: Colors.black,
          fontSize: 40,
          fontWeight: FontWeight.normal,
          fontFamily: 'Rubik',
          letterSpacing: 5,
      ),
      textInputAction: TextInputAction.done,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        hintText: "",
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(216, 218, 220, 1)
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(216, 218, 220, 1)
            ),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}