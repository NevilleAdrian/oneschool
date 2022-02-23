import 'dart:io';

import 'package:cliqlite/repository/hive_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overlay_support/overlay_support.dart';

class PushNotification {
  final FirebaseMessaging _fbm = FirebaseMessaging.instance;
  // final NavigationService _ns = NavigationService.service;

  void initialize() {
    if (Platform.isIOS) {
      //require IOS permission
      _fbm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notificationData = message.notification;
      showSimpleNotification(
        NotificationBody(
            title: notificationData.title, body: notificationData.body),
        contentPadding:
            EdgeInsets.only(bottom: 20.0, top: 20.0, left: 20.0, right: 20.0),
        background: Colors.transparent,
        autoDismiss: false,
      );
      print('done:');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      RemoteNotification notificationData = message.notification;
      var route = message.data["route"];
      var body = message.data["body"];
      var title = message.data["title"];
      //Initializing hive to get userId
      HiveRepository _hiveRepository = HiveRepository();

      showSimpleNotification(
        NotificationBody(title: title, body: body),
        contentPadding:
            EdgeInsets.only(bottom: 20.0, top: 20.0, left: 20.0, right: 20.0),
        background: Colors.transparent,
        autoDismiss: false,
      );
    });
  }

  Future<String> getDeviceToken() async {
    print('i am here');
    try {
      return await _fbm.getToken();
    } catch (ex) {
      return null;
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("onBackgroundMessagenotification: ${message.notification}");
  print("onBackgroundMessagedata: ${message.data}");
  print("onMessageOpenedApp: $message");

  var route = message.data["route"];
  var body = message.data["body"];
  var title = message.data["title"];

  showSimpleNotification(
    NotificationBody(title: title, body: body),
    contentPadding:
        EdgeInsets.only(bottom: 20.0, top: 20.0, left: 20.0, right: 20.0),
    background: Colors.transparent,
    autoDismiss: false,
  );
}

class NotificationBody extends StatelessWidget {
  const NotificationBody({
    Key key,
    @required this.title,
    @required this.body,
  }) : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding:
            EdgeInsets.only(bottom: 20.0, top: 20.0, left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/Info_Bar.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        title ?? '',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    body ?? '',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Builder(builder: (context) {
              return InkWell(
                  onTap: () {
                    OverlaySupportEntry.of(context).dismiss();
                  },
                  child: SvgPicture.asset('assets/images/Icon_close.svg'));
            })
          ],
        ),
      ),
    );
  }
}
