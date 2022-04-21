import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
      IconButton(
          icon: SvgPicture.asset('assets/icons/search-svgrepo-com.svg'),
          onPressed: () {
            showResults(context);
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    if (resultList != null) {
      return ListView.builder(
        itemCount: resultList.length,
        itemBuilder: (context, index) {
          QueryDocumentSnapshot product = resultList[index];
          return ListTile(
            leading: Image(image: NetworkImage(product.get('photo'))),
            title: RichText(
                text: TextSpan(
                    text: product
                        .get('name')
                        .toString()
                        .substring(0, query.length),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                    text:
                        product.get('name').toString().substring(query.length),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ])),
          );
        },
      );
    } else {
      return ListView();
    }
  }

  late List resultList;
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List suggestions;
    return FutureBuilder<QuerySnapshot?>(
      future:
          Database().products.doc('allProducts').collection('products').get(),
      builder: (context, snapshot) {
        suggestions = snapshot.data!.docs
            .where((element) => element
                .get('name')
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList();
        resultList = suggestions;
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot product = suggestions[index];
            return ListTile(
              leading: Image(image: NetworkImage(product.get('photo'))),
              title: RichText(
                  text: TextSpan(
                      text: product
                          .get('name')
                          .toString()
                          .substring(0, query.length),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                      text: product
                          .get('name')
                          .toString()
                          .substring(query.length),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ])),
            );
          },
        );
      },
    );
  }
}
