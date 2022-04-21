import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

import 'nav_bar_item.dart';

class NavBar extends StatelessWidget {
  final List tabItems;
  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  const NavBar({
    Key? key,
    required this.tabItems,
    required this.onTabChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            color: kShadowColor.withOpacity(0.14),
            blurRadius: 25,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabItems.length, (index) {
          return NavBarItem(
              onTabChanged: onTabChanged,
              tabItems: tabItems,
              currentIndex: currentIndex,
              index: index);
        }),
      ),
    );
  }
}
