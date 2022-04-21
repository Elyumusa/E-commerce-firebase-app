import 'package:eligere/Screens/CheckoutScreen/checkout.dart';
import 'package:eligere/Screens/HomePage/home.dart';
import 'package:eligere/Screens/ProductScreen/Widgets/beautiful_button.dart';
import 'package:eligere/Screens/ProductScreen/Widgets/modify_quantity.dart';
import 'package:eligere/blocs/cart_bloc.dart';
import 'package:eligere/constants.dart';
import 'package:flutter/material.dart';

import '../../../media_query.dart';

class CartScreen extends StatefulWidget {
  get groceryList => null;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List groceryList;

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
      body: StreamBuilder<Object>(
          stream: cartBloc.updatedCart.stream,
          builder: (context, snapshot) {
            groceryList = cartBloc.cart;

            return SafeArea(
                child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 60.0, left: 10, top: 20, bottom: 10),
                      child: Text('My Cart',
                          style: kTitleStyle.copyWith(fontSize: 30)),
                    ),
                    ...List.generate(
                      groceryList.length,
                      (index) {
                        //int quantityChosen = groceryList[index]['quantity'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Dismissible(
                            onDismissed: (direction) {
                              cartBloc.cart.remove(groceryList[index]);
                            },
                            background: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red.shade600,
                                      size: 50,
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(15)), //
                            ),
                            direction: DismissDirection.endToStart,
                            key:
                                ValueKey(groceryList[index]?['product'].id), //,
                            child: ListTile(
                              onTap: () {},
                              leading: Image(
                                image: NetworkImage(
                                    groceryList[index]['product'].get('photo')),
                              ),
                              title: Text(
                                  groceryList[index]['product'].get('name'),
                                  style: kTitleStyle),
                              subtitle: Row(
                                children: [
                                  Text(
                                    '${groceryList[index]?['product'].get('description')}',
                                    //style: kDescriptionStyle,
                                  ),
                                  const Spacer(),
                                  ModifyQuantity(
                                    add: () {
                                      setState(() {
                                        groceryList[index]['quantity'] += 1;
                                      });
                                    },
                                    remove: () {
                                      setState(() {
                                        groceryList[index]['quantity'] -= 1;
                                      });
                                    },
                                    quantity: groceryList[index]['quantity'],
                                  )
                                ],
                              ),
                              trailing: Text(
                                'K${groceryList[index]?['product'].get('price')}',
                                //style: kDescriptionStyle,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                          width: MQuery.width! * 0.70,
                          child: BeautifulButton(
                              string: 'Proceed To Order',
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return const CheckOutPage();
                                  },
                                ));
                              })),
                    )
                  ]),
            ));
          }),
    );
  }
}
