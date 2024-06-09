import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {

  final String hint;
  final TextInputFormatter? formatter;
  final TextEditingController controller;
  final TextInputAction? action;
  final TextInputType? keyboardType;
  final Function? onSubmitted;
  final bool? isPassword;

  const PrimaryTextField({super.key, required this.hint, this.formatter, required this.controller, this.action, this.keyboardType, this.onSubmitted, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      inputFormatters: formatter == null ? null : [formatter!],
      obscureText: isPassword == null ? false : true,
      autocorrect: false,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: 'Rubik'
      ),
      onFieldSubmitted: (value) {
        onSubmitted?.call(value);
      },
      maxLength: 30,
      textInputAction: action ?? TextInputAction.done,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        counterText: "",
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(194, 194, 194, 1)
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
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