import 'package:eligere/Screens/ProductScreen/Widgets/beautiful_button.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 60.0, left: 10, top: 20, bottom: 10),
              child: Text('My Cart', style: kTitleStyle.copyWith(fontSize: 30)),
            ),
            Row(
              children: [
                const Text('Email:'),
                GeneralTextField(
                  controller: emailController,
                  labelText: 'Email',
                  validator: (string) {
                    return '';
                  },
                )
              ],
            ),
            Row(
              children: [
                const Text('Phone'),
                GeneralTextField(
                  controller: emailController,
                  labelText: 'Phone',
                  validator: (string) {
                    return '';
                  },
                )
              ],
            ),
            Row(
              children: [
                const Text('Full Name:'),
                GeneralTextField(
                  controller: emailController,
                  labelText: 'Full Name',
                  validator: (string) {
                    return '';
                  },
                )
              ],
            ),
            BeautifulButton(string: 'Save', onTap: () {})
          ],
        ),
      ),
    );
  }
}

class GeneralTextField extends StatelessWidget {
  final TextEditingController controller;
  final String Function(String?) validator;
  final String labelText;
  GeneralTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      //focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.grey,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: 'Update Email from here ',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        border: OutlineInputBorder(
          //borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: 'Email',
      ),
      //autofocus: true,
      validator: (value) {},
    );
  }
}
