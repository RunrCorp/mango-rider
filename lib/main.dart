import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mango/screens/login_page.dart';
import 'package:mango/services/geolocation_service.dart';
import 'package:provider/provider.dart';

//List<CameraDescription> cameras;
//test push

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  cameras = await availableCameras();
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
        )
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
        home: new LoginPage(),
      ),
    );
  }
}
//delta
