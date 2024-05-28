import 'package:flutter/material.dart';

class ShowDialog {
  static void alertDialog(BuildContext context,
      {required String alertTitle,
      required String message,
      bool formValidation = false,
      Color color = Colors.amber}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          alertTitle,
          style: TextStyle(color: color),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (formValidation) {
                Navigator.pop(context);
              }
            },
            child: const Text(
              "OK",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  static void error(BuildContext context, String errorMessage) {
    alertDialog(context,
        alertTitle: "Error", message: errorMessage, color: Colors.red);
  }
}
