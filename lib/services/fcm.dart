import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  // singlton implementation
  static final instance = new FCM._internal();
  FCM._internal();

  FirebaseMessaging _firebaseMessaging;

  void init() {
    _firebaseMessaging = FirebaseMessaging();

    if (Platform.isIOS) _requestIosPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('FCM Token = $token');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void _requestIosPermissions() {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
