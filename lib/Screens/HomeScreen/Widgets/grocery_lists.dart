import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eligere/Screens/GroceryListScreen/grocery_list_screen.dart';
import 'package:eligere/Services/db_services.dart';
import 'package:eligere/constants.dart';
import 'package:flutter/material.dart';

import '../../../media_query.dart';

class GorceryLists extends StatelessWidget {
  List listOptions = [
    {
      'name': 'Boarding School',
      'url': 'assets/images/groceries-image.png',
      'color': Colors.orangeAccent.withOpacity(0.2)
    },
    {
      'name': 'General groceries',
      'url': 'assets/images/groceries-image.png',
      'color': kPrimaryColor.withOpacity(0.2)
    },
    {
      'name': 'Home groceries',
      'url': 'assets/images/groceries-image.png',
      'color': Colors.pink[100]!.withOpacity(0.2)
    }
  ];

  get kTitleStyle => null;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MQuery.height! * 0.11,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listOptions.length,
          itemBuilder: (context, index) {
            List groceryLists;
            switch (listOptions[index]['name']) {
              case 'Boarding School':
                return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: Database()
                        .products
                        .doc('categories')
                        .collection('boardingSchool')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return GroceryList(
                                    groceryList: snapshot.data!.docs,
                                    listName: 'Boarding School Groceries');
                              },
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(5),
                            width: MQuery.width! * 0.6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: listOptions[index]['color']),
                            child: LayoutBuilder(builder: (context, c) {
                              return Row(
                                children: [
                                  Image.asset(listOptions[index]['url'],
                                      width: c.maxWidth * 0.4),
                                  const SizedBox(width: 13),
                                  Text(
                                    listOptions[index]['name'],
                                    style: kTitleStyle,
                                  )
                                ],
                              );
                            }),
                          ),
                        );
                      }
                      return const CircularProgressIndicator.adaptive();
                    });
              case 'General groceries':
                return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: Database()
                        .products
                        .doc('categories')
                        .collection('generalGroceries')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return GroceryList(
                                    groceryList: snapshot.data!.docs,
                                    listName: 'General Groceries');
                              },
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(5),
                            width: MQuery.width! * 0.6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: listOptions[index]['color']),
                            child: LayoutBuilder(builder: (context, c) {
                              return Row(
                                children: [
                                  Image.asset(listOptions[index]['url'],
                                      width: c.maxWidth * 0.4),
                                  const SizedBox(width: 13),
                                  Text(
                                    listOptions[index]['name'],
                                    style: kTitleStyle,
                                  )
                                ],
                              );
                            }),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    });
              case 'Home groceries':
                return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: Database()
                        .products
                        .doc('categories')
                        .collection('homeGroceries')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return GroceryList(
                                    groceryList: snapshot.data!.docs,
                                    listName: 'Home Groceries');
                              },
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(5),
                            width: MQuery.width! * 0.6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: listOptions[index]['color']),
                            child: LayoutBuilder(builder: (context, c) {
                              return Row(
                                children: [
                                  Image.asset(listOptions[index]['url'],
                                      width: c.maxWidth * 0.4),
                                  const SizedBox(width: 13),
                                  Text(
                                    listOptions[index]['name'],
                                    style: kTitleStyle,
                                  )
                                ],
                              );
                            }),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    });

              default:
                return CircularProgressIndicator();
            }
            /*return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(5),
              width: MQuery.width! * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: listOptions[index]['color']),
              child: LayoutBuilder(builder: (context, c) {
                return Row(
                  children: [
                    Image.asset(listOptions[index]['url'],
                        width: c.maxWidth * 0.4),
                    const SizedBox(width: 13),
                    Text(
                      listOptions[index]['name'],
                      style: kTitleStyle,
                    )
                  ],
                );
              }),
            );
         */
          },
        ));
  }
}
