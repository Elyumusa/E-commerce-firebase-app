import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/HomeScreen/Widgets/product_card.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:flutter/material.dart';

class SeeAllScreen extends StatelessWidget {
  final String category;
  SeeAllScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: category == 'allProducts'
            ? Database()
                .products
                .doc('allProducts')
                .collection('products')
                .get()
            : Database().products.doc('categories').collection(category).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 3.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        DocumentSnapshot productDocument =
                            snapshot.data!.docs[0];
                        return GestureDetector(
                          onTap: () {},
                          child: ProductCard(
                            string: category == 'allProducts'
                                ? productDocument.id
                                : productDocument.get('product_id'),
                          ),
                        );
                      }, childCount: 36 /*snapshot.data?.docs.length ?? 0*/),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });
  }
}
