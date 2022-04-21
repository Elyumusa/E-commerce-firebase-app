/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/HomePage/home.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/blocs/cart_bloc.dart';
import 'package:eligere/models/models.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../media_query.dart';

class ProductCard extends StatefulWidget {
  ProductCard({Key? key, required this.string}) : super(key: key);
  final String? string;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late CartBloc cartBloc;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cartBloc = MyHomePage.of(context).blocProvider.cartBloc;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Object?>>(
        future: Database()
            .products
            .doc('allProducts')
            .collection('products')
            .doc(widget.string)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot grocery = snapshot.data!;
            if (grocery.exists) {
              print('grocery: ${grocery.get('name')}');
              return LayoutBuilder(builder: (context, constraints) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MQuery.width! * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: kBorderColor, width: 1.5),
                      borderRadius: BorderRadius.circular(15)),
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                          image: NetworkImage(
                        grocery.get('photo'),
                        scale: 0.2,
                      )),
                      Text(grocery.get('name'), style: kTitleStyle),
                      Text('120 per box'),
                      Spacer(),
                      Row(children: [
                        Text('K${grocery.get('price')}', style: kTitleStyle),
                        Spacer(),
                        InkResponse(
                          onTap: () {
                            addToCart(grocery);
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kPrimaryColor),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        )
                      ])
                    ],
                  ),
                );
              });
            } else {
              return const AlertDialog(
                content: Text('Document Doesnt exist'),
              );
            }
          }
          return const AlertDialog(
            content: Text('You have no connection to the internet'),
          );
        });
  }

  addToCart(DocumentSnapshot grocery) {
    if (!cartBloc.cart
        .map((e) => e['product'].id)
        .toList()
        .contains(grocery.id)) {
      print('here');
      cartBloc.cart.add({'product': grocery, 'quantity': 1});
      cartBloc.updatedCart.add(true);
    }
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/HomePage/home.dart';
import 'package:eligere/Screens/ProductScreen/product_screen.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/blocs/cart_bloc.dart';
import 'package:eligere/models/models.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../media_query.dart';

class ProductCard extends StatefulWidget {
  ProductCard({Key? key, required this.string}) : super(key: key);
  final String? string;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late CartBloc cartBloc;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cartBloc = MyHomePage.of(context).blocProvider.cartBloc;
    super.didChangeDependencies();
  }

  late bool isInternet;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Object?>>(
        future: Database()
            .products
            .doc('allProducts')
            .collection('products')
            .doc(widget.string)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot grocery = snapshot.data!;
            if (grocery.exists) {
              print('grocery: ${grocery.get('name')}');
              return InkResponse(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          NewProductScreen(productDocument: grocery)));
                },
                child: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: MQuery.width! * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(color: kBorderColor, width: 1.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                            image: NetworkImage(
                          grocery.get('photo'),
                          scale: 0.2,
                        )),
                        Text(grocery.get('name'), style: kTitleStyle),
                        const Text('120 per box'),
                        const Spacer(),
                        Row(children: [
                          Text('K${grocery.get('price')}', style: kTitleStyle),
                          const Spacer(),
                          InkResponse(
                            onTap: () {
                              addToCart(grocery);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kPrimaryColor),
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          )
                        ])
                      ],
                    ),
                  );
                }),
              );
            } else {
              return const AlertDialog(
                content: Text('Document Doesnt exist'),
              );
            }
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MQuery.width! * 0.4,
            decoration: BoxDecoration(
                border: Border.all(color: kBorderColor, width: 1.5),
                borderRadius: BorderRadius.circular(15)),
          );
          /*return const Center(
              child: SizedBox(
                  height: 50, child: CircularProgressIndicator.adaptive()));*/
        });
  }

  addToCart(DocumentSnapshot grocery) {
    if (!cartBloc.cart
        .map((e) => e['product'].id)
        .toList()
        .contains(grocery.id)) {
      print('here');
      cartBloc.cart.add({'product': grocery, 'quantity': 1});
      cartBloc.updatedCart.add(true);
    }
  }
}
