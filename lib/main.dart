import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart'; // flutter_config
import 'package:mango/screens/home.dart';
import 'package:mango/screens/login_page.dart';
import 'package:mango/services/geolocation_service.dart';
import 'package:provider/provider.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables(); // flutter_config
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final GeoLocatorService geoLocatorService = GeoLocatorService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => geoLocatorService.getCoords(),
        ),
        StreamProvider(
          create: (context) => geoLocatorService.trackLocation(),
        ),
        FutureProvider<FirebaseUser>(
          create: (context) => FirebaseAuth.instance.currentUser(),
        ),
      ],
      child: new MaterialApp(
        title: "Runr",
        theme: new ThemeData(
            primaryColor: new Color(0xffe23149),
            accentColor: new Color(0xffe23149),
            backgroundColor: new Color(0xffe23149),
            unselectedWidgetColor: new Color(0xffe23149),
            primarySwatch: Colors.deepOrange,
            brightness: Brightness.light,
            fontFamily: 'Quicksand'),
        darkTheme: ThemeData(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: _handleWindowDisplay(),
      ),
    );
  }
} //delta

Widget _handleWindowDisplay() {
  return FutureBuilder(
    future: FirebaseAuth.instance.currentUser(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(body: Center(child: LinearProgressIndicator()));
      } else if (snapshot.hasData && snapshot.data != null) {
        return HomePage(snapshot.data); // clean and elegant solution
      } else {
        return LoginPage();
      }
    },
  );
}
