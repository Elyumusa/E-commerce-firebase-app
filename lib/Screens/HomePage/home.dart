import 'package:eligere/Screens/Authentication/phone_sign_up.dart';
import 'package:eligere/Screens/CartScreen/cart_screen.dart';
import 'package:eligere/Screens/GroceryListScreen/grocery_list_screen.dart';
import 'package:eligere/Screens/HomePage/stackofpages.dart';
import 'package:eligere/Screens/NotificationsScreen/notifications_screen.dart';
import 'package:eligere/Screens/ProductScreen/product_screen.dart';
import 'package:eligere/Services/data_connection_checker.dart';
import 'package:eligere/Services/internet.dart';
import 'package:eligere/Services/notification_settings.dart';
import 'package:eligere/main.dart';
import 'package:eligere/models/models.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'Widgets/nav_bar.dart';
import '../HomeScreen/home_screen.dart';

class MyHomePage extends StatefulWidget {
  final BlocProvider bloc;
  MyHomePage({Key? key, required this.bloc}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
  static _MyHomePageState of(context) {
    return context.dependOnInheritedWidgetOfExactType<AppInheritor>().data;
  }
}

class AppInheritor extends InheritedWidget {
  final _MyHomePageState data;
  final Widget child;
  AppInheritor({Key? key, required this.data, required this.child})
      : super(key: key, child: child);
  @override
  bool updateShouldNotify(AppInheritor oldWidget) {
    return true;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  BlocProvider get blocProvider => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    ////When the app is  terminated and the user clicks on the notification
    FirebaseMessaging.instance.getInitialMessage().then((value) {});
    print('We about after');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = notification.android!;
      //widget.bloc.userAuthStatebloc.notifications.add(message);
      //widget.bloc.userAuthStatebloc.notificationsController.add(true);
      NotificationsSettings.initialize();
      NotificationsSettings.display(notification);
      widget.bloc.notificationsBloc.notifications.add(message);
      widget.bloc.notificationsBloc.newNotifications.add(true);
      print('we are in foreground ${notification.body}');
      print('notification title ${notification.title}');
    });
    //When the app is in background and not terminated and the user clicks on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('The onMessageOpenedApp callback is working');
    });
    widget.bloc.internetBloc.dc.onStatusChange.listen((event) {
      print('Listener works!!!!!');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppInheritor(
        data: this,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: FutureBuilder(
                future: isInternet(widget.bloc.internetBloc.dc),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == true) {
                      return OtpPage();
                    } else {
                      return const Scaffold(
                          body: Center(child: CircularProgressIndicator()));
                      /*return SnackBar(
                              content: Row(
                            children: [
                              const Text(
                                  'No Internet Connection, whatever you will do now, is offline'),
                              TextButton(
                                  onPressed: () async {
                                    await dc.hasConnection;
                                  },
                                  child: const Text('Retry'))
                            ],
                          ));
                        */
                    }
                  }
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                })));
  }
}
