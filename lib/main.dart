import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mango/screens/login_page.dart';

//List<CameraDescription> cameras;
//test push

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Runner",
      theme: new ThemeData(
        primaryColor: new Color(0xffe23149),
        accentColor: new Color(0xffe23149),
        backgroundColor: new Color(0xffe23149),
        unselectedWidgetColor: new Color(0xffe23149),
      ),
      debugShowCheckedModeBanner: false,
      home: new LoginPage(),
    );
  }
}
//delta
