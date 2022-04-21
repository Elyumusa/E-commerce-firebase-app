import 'package:flutter/material.dart';

import '../../../constants.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  const AuthTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Text(title,
          style: TextStyle(
              color: kPrimaryColor.withOpacity(0.2),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.5)),
    );
  }
}
