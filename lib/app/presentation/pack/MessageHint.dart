import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MessageHint {

  static void showMessage(String message) => Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.TOP,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color.fromRGBO(249, 126, 134, 1),
    textColor: Colors.white,
    fontSize: 16.0,
  );

}