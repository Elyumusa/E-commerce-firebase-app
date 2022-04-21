import 'package:flutter/material.dart';

import '../../../constants.dart';

class ModifyQuantity extends StatefulWidget {
  final int quantity;
  final VoidCallback add;
  final VoidCallback remove;
  const ModifyQuantity({
    required this.quantity,
    required this.add,
    required this.remove,
    Key? key,
  }) : super(key: key);

  @override
  State<ModifyQuantity> createState() => _ModifyQuantityState();
}

class _ModifyQuantityState extends State<ModifyQuantity> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: widget.add,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kPrimaryColor.withOpacity(0.2),
            ),
            child: const Icon(Icons.add, color: Colors.black),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Text('${widget.quantity}'),
        ),
        InkWell(
          onTap: () {
            widget.remove();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kPrimaryColor.withOpacity(0.2),
            ),
            child: const Icon(Icons.remove, color: Colors.black),
          ),
        )
      ],
    );
  }
}
