import 'package:eligere/Screens/CartScreen/cart_screen.dart';
import 'package:eligere/Screens/HomeScreen/home_screen.dart';
import 'package:eligere/Screens/Menu/menu_page.dart';
import 'package:eligere/Screens/NotificationsScreen/notifications_screen.dart';
import 'package:flutter/material.dart';

import 'Widgets/nav_bar.dart';

class StackOfPages extends StatefulWidget {
  const StackOfPages({Key? key}) : super(key: key);

  @override
  _StackOfPagesState createState() => _StackOfPagesState();
}

List tabIcons = List.unmodifiable([
  {'icon': 'assets/icons/shop.svg', 'title': 'Shop'},
  {'icon': 'assets/icons/cart.svg', 'title': 'Cart'},
  {'icon': 'assets/icons/profile.svg', 'title': 'Menu'},
  {'icon': 'assets/icons/notifications.svg', 'title': 'Notifications'}
]);
int currentIndex = 0;
List pageContent = [
  HomeScreen(),
  CartScreen(),
  MenuPage(),
  NotificationsPage()
];

class _StackOfPagesState extends State<StackOfPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pageContent[currentIndex],
        bottomNavigationBar: NavBar(
          currentIndex: currentIndex,
          tabItems: tabIcons,
          onTabChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ));
  }
}
