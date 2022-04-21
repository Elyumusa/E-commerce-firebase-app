import 'package:connectivity_plus/connectivity_plus.dart';

import 'data_connection_checker.dart';

Future<bool> isInternet(DataConnectionChecker dc) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network, make sure there is actually a net connection.
    return await checkConnection(dc);
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a WIFI network, make sure there is actually a net connection.
    return await checkConnection(dc);
  } else {
    // Neither mobile data or WIFI detected, not internet connection found.
    return false;
  }
}

Future<bool> checkConnection(DataConnectionChecker dc) async {
  if (await dc.hasConnection) {
    // Wifi detected & internet connection confirmed.
    return true;
  } else {
    // Wifi detected but no internet connection found.
    return false;
  }
}
