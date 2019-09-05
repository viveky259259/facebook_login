import 'dart:io';

import 'package:easy_alert/easy_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;
  BuildContext context;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  void setUpFirebase(BuildContext context) {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();
    this.context = context;
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        Alert.alert(navigatorKey.currentContext,
                title: "Hello", content: "this is a alert")
            .then((_) => Alert.toast(context, "You just click ok"));

        Alert.alert(context, title: "Hello", content: "this is a alertaaa")
            .then((_) => Alert.toast(context, "You just click ok"));
//        navigatorKey.currentState
//            .push(MaterialPageRoute(builder: (c) => NotificationUi(message)));

//        navigatorKey.currentState.push(
//            MaterialPageRoute(builder: (context) => NotificationUi(message)));
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
