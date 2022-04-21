import 'dart:async';

import 'package:eligere/Services/data_connection_checker.dart';

class CartBloc {
  List cart = [];
  StreamController<bool> updatedCart = StreamController.broadcast();
}

class NotificationsBloc {
  List notifications = [];
  StreamController<bool> newNotifications = StreamController.broadcast();
}

class OrdersBloc {
  List orders = [];
}

class InternetBloc {
  DataConnectionChecker dc = DataConnectionChecker();
}
