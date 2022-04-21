import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/HomeScreen/Widgets/product_card.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/media_query.dart';
import 'package:eligere/models/models.dart';
import 'package:flutter/material.dart';

class BestSelling extends StatefulWidget {
  @override
  State<BestSelling> createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  late List? bestSelling;

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
        .collection('bestSelling')
        .doc('BoxNoodles')
        .set({'product_id': 'BoxNoodles'});
    await Database()
        .products
        .doc('categories')
        .collection('bestSelling')
        .doc('PacketOfWater')
        .set({'product_id': 'PacketOfWater'});
    await Database()
        .products
        .doc('categories')
        .collection('bestSelling')
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
                .collection('bestSelling')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                bestSelling = snapshot.data?.docs;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bestSelling?.length,
                  itemBuilder: (context, index) {
                    print(
                        ' best selling: ${bestSelling?[index].get('product_id')}');
                    return ProductCard(
                      string: bestSelling?[index].get('product_id'),
                    );
                  },
                );
              }
              return const CircularProgressIndicator.adaptive();
            }));
  }
}
