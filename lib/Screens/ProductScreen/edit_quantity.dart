import 'package:eligere/Screens/ProductScreen/button_container.dart';
import 'package:flutter/material.dart';

class EditQuantityWidget extends StatelessWidget {
  const EditQuantityWidget({
    Key? key,
    @required this.addFunction,
    @required this.removeFunction,
    @required this.quantity,
  }) : super(key: key);

  final VoidCallback? addFunction;
  final VoidCallback? removeFunction;
  final num? quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ButtonContainer(
            child: InkWell(
              onTap: removeFunction,
              child: Icon(
                Icons.remove,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Center(
            child: Text(
              '$quantity',
              // style: TextStyle(fontSize: 12),
              style: TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          ButtonContainer(
            child: InkWell(
              onTap: addFunction,
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
