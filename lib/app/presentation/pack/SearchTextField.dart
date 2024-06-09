import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  final TextInputAction? action;
  final Function? onSubmitted;

  const SearchTextField({super.key, required this.hint, required this.controller, this.action, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromRGBO(216, 218, 220, 1)
        )
      ),
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Row(
        children: [
          const SizedBox(
            width: 28,
            child: Icon(
              Icons.search_rounded,
              color: Color.fromRGBO(117, 117, 117, 1),
              size: 28,
            ),
          ),
          Expanded(
            child: TextFormField(
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Rubik'
              ),
              onFieldSubmitted: (value) {
                onSubmitted?.call();
                print(value);
              },
              maxLength: 30,
              textInputAction: action ?? TextInputAction.done,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                counterText: "",
                border: const OutlineInputBorder(),
                hintText: hint,
                hintStyle: const TextStyle(
                    color: Color.fromRGBO(117, 117, 117, 1)
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}