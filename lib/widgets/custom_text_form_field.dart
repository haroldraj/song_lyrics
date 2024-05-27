import 'package:flutter/material.dart';

Widget customTextFormField(
    {String? labelText, TextEditingController? fieldController}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: TextFormField(
      controller: fieldController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the $labelText';
        }
        return null;
      },
    ),
  );
}
