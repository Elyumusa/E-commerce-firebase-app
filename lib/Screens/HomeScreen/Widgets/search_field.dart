import 'package:eligere/Screens/SearchPage/search.dart';
import 'package:eligere/constants.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: kSecondaryColor, borderRadius: BorderRadius.circular(15)),
        child: TextField(
          onTap: () {
            showSearchPage(context);
          },
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search....',
              prefixIcon: Icon(Icons.search)),
        ));
  }

  void showSearchPage(BuildContext context) {
    showSearch(context: context, delegate: ProductSearch());
  }
}
