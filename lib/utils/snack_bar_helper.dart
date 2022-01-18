import 'package:flutter/material.dart';

class SnackBarHelper {
  static showTextMsg({required context, required msg}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$msg"),
    ));
  }
}
