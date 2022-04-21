import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/HomeScreen/Widgets/product_card.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/constants.dart';
import 'package:eligere/models/models.dart';
import 'package:flutter/material.dart';

import '../../../media_query.dart';

class ExclusiveOffers extends StatefulWidget {
  @override
  State<ExclusiveOffers> createState() => _ExclusiveOffersState();
}

class _ExclusiveOffersState extends State<ExclusiveOffers> {
  late List? exclusiveOffers;
  /* List.generate(6, (index) {
    return MGrocery(
        name: 'Box Of Milkit',
        url: 'assets/images/BoxMilkit.jpg',
        description: 'Get yourself a box of milkit at an affordable price',
        price: 80.00);
  });
 */
  @override
  void initState() {
    // TODO: implement initState
    //addProducts();
    super.initState();
  }

  addProducts() async {
    await Database()
        .products
        .doc('categories')
        .collection('exclusiveOffers')
        .doc('BoxNoodles')
        .set({'product_id': 'BoxNoodles'});
    await Database()
        .products
        .doc('categories')
        .collection('exclusiveOffers')
        .doc('PacketOfWater')
        .set({'product_id': 'PacketOfWater'});
    await Database()
        .products
        .doc('categories')
        .collection('exclusiveOffers')
        .doc('BoxMilkit')
        .set({'product_id': 'BoxMilkit'});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MQuery.height! * 0.3,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: Database()
                .products
                .doc('categories')
                .collection('exclusiveOffers')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                exclusiveOffers = snapshot.data?.docs;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: exclusiveOffers?.length,
                  itemBuilder: (context, index) {
                    print(
                        ' exclusive: ${exclusiveOffers?[index].get('product_id')}');
                    return ProductCard(
                      string: exclusiveOffers?[index].get('product_id'),
                    );
                  },
                );
              }
              return const CircularProgressIndicator.adaptive();
            }));
  }
}
