//buttons adapted from: https://api.flutter.dev/flutter/material/RaisedButton-class.html

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    offerClass d1 = new offerClass(
        "Bilbo", Image.asset("assets/bagginso.png"), 3, "\$3.45");
    offerClass d2 =
        new offerClass("Robert", Image.asset("assets/marlo.png"), 5, "\$4.20");
    offerClass d3 =
        new offerClass("Gnome", Image.asset("assets/elfo.png"), 2, "\$109.22");

    return Scaffold(
        appBar: AppBar(title: Text("Current Offers")),
        backgroundColor: Colors.grey[100],
        body: Column(children: [
          d1.build(context),
          d2.build(context),
          d3.build(context)
        ]));
  }
}

//class for each offer which appears
class offerClass extends StatelessWidget {
  String Drivername;
  String RideCost;
  Image DriverPicture;
  int DriverRating;

  offerClass(
      this.Drivername, this.DriverPicture, this.DriverRating, this.RideCost);

  @override
  Widget build(BuildContext context) {
    RatingClass ratebox = new RatingClass(DriverRating);
    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    return Container(
        color: Colors.white,
        height: (1 / 8 * ScreenHeight),
        margin: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 6.0, right: 6.0),
        child: Row(children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 3.0),
            child: DriverPicture,
            alignment: Alignment.topLeft,
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 3.0, right: 3.0),
                      child: Text(Drivername, style: TextStyle(fontSize: 12))),
                  Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(left: 3.0, right: 3.0),
                      child: ratebox.build(context))
                ],
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Ride has been accepted and is on the way")));
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              Navigator.of(context).pop();
                            });
                          }, //someone who knows what they're doing, help me out here
                          child: Container(
                              child: Text("ACCEPT",
                                  style: TextStyle(color: Colors.white)))),
                      RaisedButton(
                          color: Colors.red,
                          onPressed: () {},
                          child: Container(
                              child: Text(
                            "DENY",
                            style: TextStyle(color: Colors.white),
                          ))),
                      Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(left: 3.0, right: 3.0),
                          child: Text(RideCost.toString()))
                    ],
                  ))
            ],
          )
        ]));

    throw UnimplementedError();
  }
}

class RatingClass extends StatelessWidget {
  int rating;
  RatingClass(int rating) {
    this.rating = rating;
    if (rating < 0) this.rating = 0;
    if (rating > 5) this.rating = 5;
  }

  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;

    Image Empty = Image.asset("assets/missingmango.png",
        height: ScreenWidth * 1 / 27, width: ScreenWidth * 1 / 27);
    Image full = Image.asset("assets/mango.png",
        height: ScreenWidth * 1 / 27, width: ScreenWidth * 1 / 27);

    if (rating == 0)
      return Row(children: <Widget>[Empty, Empty, Empty, Empty, Empty]);
    if (rating == 1)
      return Row(children: <Widget>[Empty, Empty, Empty, Empty, full]);
    if (rating == 2)
      return Row(children: <Widget>[Empty, Empty, Empty, full, full]);
    if (rating == 3)
      return Row(children: <Widget>[Empty, Empty, full, full, full]);
    if (rating == 4)
      return Row(children: <Widget>[Empty, full, full, full, full]);
    if (rating == 5)
      return Row(children: <Widget>[full, full, full, full, full]);
  }
}
