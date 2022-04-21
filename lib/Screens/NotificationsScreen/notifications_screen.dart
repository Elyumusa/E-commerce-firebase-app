import 'package:eligere/Screens/HomePage/home.dart';
import 'package:eligere/blocs/cart_bloc.dart';
import 'package:eligere/constants.dart';
import 'package:eligere/media_query.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationsBloc notificationsBloc;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    notificationsBloc = MyHomePage.of(context).blocProvider.notificationsBloc;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: StreamBuilder<Object>(
            stream: notificationsBloc.newNotifications.stream,
            builder: (context, snapshot) {
              return notificationsBloc.notifications.isEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/notifications.svg',
                              height: MQuery.height! * 0.75,
                              width: double.infinity,
                              color: kPrimaryColor.withOpacity(0.2),
                            ),
                          ),
                        ),
                        Text('No Notifications',
                            style: kTitleStyle.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 26))
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 60.0, left: 10, top: 20, bottom: 10),
                            child: Text('Notifications',
                                style: kTitleStyle.copyWith(fontSize: 30)),
                          ),
                          ...List.generate(
                              notificationsBloc.notifications.length, (index) {
                            RemoteMessage message =
                                notificationsBloc.notifications[index];
                            return Dismissible(
                                onDismissed: (DismissDirection direction) {
                                  // notifications.removeAt(index);
                                },
                                background: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: const [
                                      Spacer(),
                                      Icon(
                                        Icons.delete_outline,
                                        color: Colors.deepOrangeAccent,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(15)), //
                                ),
                                direction: DismissDirection.endToStart,
                                key: ValueKey(
                                    DateTime.now().millisecondsSinceEpoch +
                                        index),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${message.notification!.title}', //'Account Creation', //, //,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '${message.notification!.body}',
                                        //'presentAlert: bool?,  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)presentBadge: bool?,  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)presentSound: bool?,  // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)',
                                        maxLines: 4,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '${DateTime.now().toUtc()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0, 2),
                                            color: Colors.black26)
                                      ],
                                      border: Border.all(
                                          width: 2.0,
                                          color:
                                              kPrimaryColor.withOpacity(0.5))),
                                ));
                          })
                        ]);
            }),
      ),
    );
  }
}
