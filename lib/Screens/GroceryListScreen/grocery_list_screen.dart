import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/CartScreen/cart_screen.dart';
import 'package:eligere/Screens/HomePage/home.dart';
import 'package:eligere/Screens/ProductScreen/Widgets/beautiful_button.dart';
import 'package:eligere/Screens/ProductScreen/Widgets/modify_quantity.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/blocs/cart_bloc.dart';
import 'package:eligere/constants.dart';
import 'package:flutter/material.dart';

import '../../media_query.dart';

class GroceryList extends StatefulWidget {
  List groceryList;
  final String listName;
  GroceryList({Key? key, required this.groceryList, required this.listName})
      : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List finalList = [];
  @override
  void initState() {
    // TODO: implement initState
    widget.groceryList =
        widget.groceryList.map((e) => {'product': e, 'quantity': 0}).toList();
    super.initState();
  }

  late CartBloc cartBloc;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cartBloc = MyHomePage.of(context).blocProvider.cartBloc;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(
                right: 60.0, left: 10, top: 20, bottom: 10),
            child: Text(widget.listName,
                style: kTitleStyle.copyWith(fontSize: 30)),
          ),
          ...List.generate(
            widget.groceryList.length,
            (index) {
              return FutureBuilder<DocumentSnapshot<Object?>>(
                  future: Database()
                      .products
                      .doc('allProducts')
                      .collection('products')
                      .doc(
                          '${widget.groceryList[index]['product'].get('product_id')}')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DocumentSnapshot product = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: () {},
                          leading: Image(
                            image: NetworkImage(product.get('photo')),
                          ),
                          title: Text(product.get('name'), style: kTitleStyle),
                          subtitle: Row(
                            children: [
                              Text(
                                'K${product.get('price')}',
                                //style: kDescrip tionStyle,
                              ),
                              Spacer(),
                              ModifyQuantity(
                                add: () {
                                  setState(() {
                                    widget.groceryList[index]['quantity'] += 1;
                                  });
                                },
                                remove: () {
                                  setState(() {
                                    widget.groceryList[index]['quantity'] -= 1;
                                  });
                                },
                                quantity: widget.groceryList[index]['quantity'],
                              )
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                if (finalList.map((e) => e['product']).contains(
                                    widget.groceryList[index]['product'])) {
                                  setState(() {
                                    finalList.remove(widget.groceryList[index]);
                                  });
                                } else {
                                  setState(() {
                                    finalList.add({
                                      'product': snapshot.data,
                                      'quantity': widget.groceryList[index]
                                          ['quantity']
                                    });
                                  });
                                }
                              },
                              icon: Icon(
                                finalList.map((e) => e['product'].id).contains(
                                        widget.groceryList[index]['product'].id)
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: kPrimaryColor,
                              )),
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                      width: MQuery.width! * 0.60,
                      child: Row(
                        children: [
                          BeautifulButton(
                              string: 'Proceed To Cart',
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return CartScreen();
                                  },
                                ));
                              }),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                      width: MQuery.width! * 0.80,
                      child: Row(
                        children: [
                          BeautifulButton(
                              string: 'Add Selected To Cart',
                              onTap: () {
                                if (finalList.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "You haven't selected anything yet")));
                                }
                                for (var grocery in finalList) {
                                  cartBloc.cart.add(grocery);
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Successfully added to cart")));
                              }),
                        ],
                      )),
                ),
              ],
            ),
          )
        ]),
      )),
    );
  }
}
