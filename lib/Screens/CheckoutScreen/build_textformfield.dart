import 'package:flutter/material.dart';

TextFormField buildTextFormField(String string, bool autofocus,
    void Function(String? data) onsaved, TextEditingController controller,
    {void Function(String data)? onChanged}) {
  return TextFormField(
    //focusNode: focusNode,
    onSaved: onsaved,
    onChanged: onChanged,
    controller: controller == null ? null : controller,
    decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
        hintText: 'Enter $string here',
        labelText: string,
        suffixIcon: Icon(Icons.account_box)),
    autofocus: autofocus,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field cannot be empty';
      } else {
        return null;
      }
    },
  );
}
