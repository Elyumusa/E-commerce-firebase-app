import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'Screens/Authentication/phone_sign_up.dart';
import 'Screens/HomePage/home.dart';

import 'Services/notification_settings.dart';
import 'blocs/cart_bloc.dart';
import 'constants.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  final plugin = NotificationsSettings.flutterLocalNotificationsPlugin;
  await plugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(NotificationsSettings.channel);
  NotificationsSettings.initialize();
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushFCMtoken();
  runApp(const MyApp());
}

void pushFCMtoken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print('token: $token');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 9000);
    //FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
    return MyHomePage(
      bloc: BlocProvider(
          internetBloc: InternetBloc(),
          cartBloc: CartBloc(),
          notificationsBloc: NotificationsBloc(),
          ordersBloc: OrdersBloc()),
    );
  }
}

class BlocProvider {
  CartBloc cartBloc;
  NotificationsBloc notificationsBloc;
  OrdersBloc ordersBloc;
  InternetBloc internetBloc;
  BlocProvider(
      {required this.cartBloc,
      required this.internetBloc,
      required this.notificationsBloc,
      required this.ordersBloc});
}
