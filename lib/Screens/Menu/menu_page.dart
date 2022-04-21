import 'package:eligere/Screens/Authentication/log_in.dart';
import 'package:eligere/Screens/MyOrders/my_orders.dart';
import 'package:eligere/Services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            trailing: const Icon(Icons.logout_outlined),
            title: const Text('Log Out'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogIn(),
                  ));
              AuthService().auth.signOut();
            },
          ),
          ListTile(
            trailing: const Icon(Icons.logout_outlined),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOrdersPage(),
                  ));
            },
          )
        ],
      )),
    );
  }
}
