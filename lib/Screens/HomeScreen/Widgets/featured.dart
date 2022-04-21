import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/HomeScreen/Widgets/product_card.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/models/models.dart';
import 'package:flutter/material.dart';

import '../../../media_query.dart';

class FeaturedProducts extends StatelessWidget {
  late List? featured;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MQuery.height! * 0.3,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: Database()
                .products
                .doc('allProducts')
                .collection('products')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                featured = snapshot.data?.docs;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featured?.length,
                  itemBuilder: (context, index) {
                    print(' featured: ${featured?[index].id}');
                    return ProductCard(
                      string: featured?[index].id,
                    );
                  },
                );
              }
              return const CircularProgressIndicator.adaptive();
            }));
  }
}
