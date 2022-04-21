import 'package:flutter/material.dart';

import '../../../constants.dart';

class BeautifulButton extends StatelessWidget {
  final String string;
  final VoidCallback onTap;
  const BeautifulButton({
    Key? key,
    required this.string,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap
      /* if (!cartBloc.cart
            .map((e) => e['product'].id) 
            .contains(widget.productDocument.id)) {
          print('It is not in cart so you can add');
          cartBloc.cart.add({
            'product': widget.productDocument,
            'quantity': quantityChosen
          });
          cartBloc.updatedCart.add(true);
        } else {
          print('already in cart');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'You already added this item to the cart')));
        }
        
        cartBloc.updatedCart.add(true);*/
      ,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(string,
                style:
                    Theme.of(context).textTheme.button?.copyWith(fontSize: 17)),
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
            )
          ],
        ),
      ),
    );
  }
}
