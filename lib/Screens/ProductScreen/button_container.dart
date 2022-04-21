import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final Widget child;
  const ButtonContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(offset: Offset(2, 2), color: Colors.grey)],
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          shape: BoxShape.circle),
      //width: getProportionateScreenWidth(context, 20),
      height: 34,
      width: 34,
      child: child,
    );
  }
}
