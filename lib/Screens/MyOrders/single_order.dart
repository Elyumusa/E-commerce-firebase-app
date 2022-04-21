import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SingleOrder extends StatelessWidget {
  final order;
  const SingleOrder({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: const Icon(Icons.arrow_back_outlined),
          //backgroundColor: Color(0xFFF5F6F9),
          title: const Text('My Order'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_basket_outlined),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 60.0, left: 10, top: 20, bottom: 10),
              child: Text('ORDER: ${order.get('order_id')}',
                  style: kTitleStyle.copyWith(fontSize: 30)),
            ),
            Text(
              order.get('cod') == true
                  ? 'Payment Type: Cash on Delivery'
                  : 'Payment Type: Pay Online',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...List.generate(
              order.get('products').length,
              (index) {
                //int quantityChosen = groceryList[index]['quantity'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FutureBuilder<DocumentSnapshot<Object?>>(
                      future: Database()
                          .products
                          .doc(order.get('products')[index])
                          .get(),
                      builder: (context, snapshot) {
                        final product = snapshot.data;
                        return ListTile(
                          onTap: () {},
                          leading: Image(
                            image: NetworkImage(product!.get('photo')),
                          ),
                          title: Text(product.get('name'), style: kTitleStyle),
                          subtitle: Row(
                            children: [
                              Text(
                                '${product.get('description')}',
                                //style: kDescriptionStyle,
                              ),
                            ],
                          ),
                          trailing: Text(
                            'K${product.get('price')}',
                            //style: kDescriptionStyle,
                          ),
                        );
                      }),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        )));
  }
}
