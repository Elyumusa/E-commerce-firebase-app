import 'package:flutter/material.dart';

class BuildEmailField extends StatelessWidget {
  RegExp? regExp;
  void Function(String? data)? onSaved;
  void Function(String data)? onChanged;
  String p;
  TextEditingController? controller;
  BuildEmailField({Key? key, this.controller, this.onSaved, this.onChanged})
      : p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    regExp = RegExp(p);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: true,
      controller: controller,
      onSaved: onSaved,
      // ignore: prefer_if_null_operators
      onChanged: onChanged != null
          ? onChanged
          : (value) {
              if (value.length < 8 || value.isEmpty) {
                // ignore: void_checks
                //return 'Please enter valid email';
              } else {
                //_formkey.currentState.validate();
                return null;
              }
            },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        hintText: 'Enter your email',
        suffixIcon: Icon(Icons.email_outlined),
        labelText: 'Email',
      ),
      // ignore: missing_return
      validator: (value) {
        if (value!.isEmpty) {
          //removeErrors('Email not valid');
          return 'Please enter email';
        } else if (value.length < 8) {
          return 'Email not valid';
        } else {
          if (regExp!.hasMatch(value) == true) return null;
          return 'Email not valid';
        }
      },
    );
  }
}
