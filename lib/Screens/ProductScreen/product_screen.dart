import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/HomePage/home.dart';
import 'package:eligere/Screens/ProductScreen/Widgets/beautiful_button.dart';
import 'package:eligere/blocs/cart_bloc.dart';
import 'package:eligere/constants.dart';
import 'package:eligere/media_query.dart';
import 'package:flutter/material.dart';

import 'Widgets/list_flavors.dart';
import 'Widgets/modify_quantity.dart';
import 'edit_quantity.dart';

class NewProductScreen extends StatefulWidget {
  final DocumentSnapshot productDocument;
  const NewProductScreen({Key? key, required this.productDocument})
      : super(key: key);

  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

int quantityChosen = 1;

class _NewProductScreenState extends State<NewProductScreen> {
  List<Color> colors = [
    Colors.white,
    Colors.purple,
    Colors.orange,
    Colors.black
  ];
  List flavors = ['Bannana', 'StrawBerry', 'Chocolate', 'Vanilla'];
  late CartBloc cartBloc;
  late StreamController<bool> updatedCart;
  void didChangeDependencies() {
    cartBloc = MyHomePage.of(context).blocProvider.cartBloc;
    updatedCart = MyHomePage.of(context).blocProvider.cartBloc.updatedCart;
    super.didChangeDependencies();
  }

  List chosenFlavors = [];
  num selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                Icon(
                  Icons.shopping_basket_outlined,
                  size: 31,
                ),
                //if (cartBloc.cart.isNotEmpty)
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: StreamBuilder<Object>(
                      //stream: updatedCart.stream,
                      builder: (context, snapshot) {
                    return Container(
                      height: 14,
                      width: 14,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orangeAccent),
                      child: Text(''),
                    );
                  }),
                )
              ],
            ),
            color: Colors.white,
          )
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          'Product Details',
          style: TextStyle(fontSize: 20),
        ),
        //backgroundColor: Colors.white,
      ),
      */
      body: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(
              url: widget.productDocument.get('photo'),
            ),
            LineProductDetails(productDocument: widget.productDocument),
            const SizedBox(height: 10),
            ModifyQuantity(
              add: () {
                setState(() {
                  quantityChosen += 1;
                });
              },
              remove: () {
                setState(() {
                  quantityChosen += 1;
                });
              },
              quantity: quantityChosen,
            ),
            ListFlavors(flavors: flavors, chosenFlavors: chosenFlavors),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BeautifulButton(
                    string: 'Add To Cart',
                    onTap: () {},
                  ),
                  CartButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String url;
  const ProductImage({
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 305,
      child: Image(
          image: NetworkImage(
        url,
        scale: 0.2,
      )),
    );
  }
}

class LineProductDetails extends StatelessWidget {
  final DocumentSnapshot productDocument;
  const LineProductDetails({
    required this.productDocument,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: '${productDocument.get('name')}\n', // 'Summer Black Tee\n',
              style: kTitleStyle.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          TextSpan(
              //text: '36 pckts per box',
              text: productDocument.get('description'),
              style: kDescriptionStyle)
        ])),
        Text('K${productDocument.get('price').toStringAsFixed(2)} ',
            style: kTitleStyle.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            )),
      ],
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return CartScreen();
          },
        ));*/
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor.withOpacity(0.26)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(14),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: kPrimaryColor),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      height: 28,
                      width: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: StreamBuilder<Object>(
                          // stream: updatedCart.stream,
                          builder: (context, snapshot) {
                        return Text(
                          '1', //'${cartBloc.cart.length}',
                          style: Theme.of(context).textTheme.button,
                        );
                      }),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class CoolAppBar extends StatelessWidget {
  const CoolAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 35,
            )),
        IconButton(
            onPressed: () {
              /*Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Account();
                },
              ));*/
            },
            icon: Icon(Icons.menu_rounded))
      ],
    );
  }
}
