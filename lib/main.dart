import 'package:flutter/material.dart';
import './pages/index.dart';
import 'services/fcm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    FCM.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World News',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: IndexPage(),
      builder: (context, widget) {
        // this can be used to change the app direction from ltr to rtl for internationalization
        return Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        );
      },
    );
  }
}
