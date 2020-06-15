import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OffersPage extends StatefulWidget{



  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  Widget build(BuildContext context){

    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    offerClass d1 = new offerClass("bilbo baggins", Image.asset("assets/baggins.png"), 3, "\$3.45");
    offerClass d2 = new offerClass("Bob Marley", Image.asset("assets/marley.png"), 5, "\$4.20");
    offerClass d3 = new offerClass("uuuuuuuuuuuuuu", Image.asset("assets/elf.png"), 2, "\$109.22");

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text("Current Offers")),

        body:


        Column(children: [

          d1.build(context),
          d2.build(context),
          d3.build(context)
      ])
      )
    );

  }
}

class offerClass extends StatelessWidget{

  //constructor stuff below

  String Drivername;
  String RideCost;
  Image DriverPicture;
  int DriverRating;

  offerClass(this.Drivername,this.DriverPicture,this.DriverRating,this.RideCost);

  @override
  Widget build(BuildContext context) {

    RatingClass ratebox = new RatingClass(DriverRating);
    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    return Container(height: (1/8 * ScreenHeight),child: Row(children: <Widget>[

      Container(child: DriverPicture, alignment: Alignment.topLeft,),

      Column(
          children: <Widget>[
            Row(
              children: <Widget>[

                Text(Drivername, style: TextStyle(fontSize: 12)),
                Text(RideCost.toString()),
                ratebox.build(context)
              ],
            ),
            Container(alignment: Alignment.centerLeft,child: Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: null, //someone who knows what they're doing, help me out here
                  child: Container(
                    color: Colors.green,
                    child: Text("ACCEPT")
                  )

                ),
                RaisedButton(
                  onPressed: null, //again, idk how this is supposed to work, so I'm gonna need some help here
                  child: Container(
                    color: Colors.red,
                    child: Text("DENY")
                  )
                )
              ],
            ))
          ],
        )]));

    throw UnimplementedError();
  }
}

class RatingClass extends StatelessWidget{

  int rating;
  RatingClass(int rating){
    this.rating = rating;
    if (rating < 0)
      this.rating = 0;
    if (rating > 5)
      this.rating = 5;

  }



  @override
  Widget build(BuildContext context) {

    final ScreenWidth = MediaQuery.of(context).size.width;

    Image Empty = Image.asset("assets/missingmango.png",height: ScreenWidth * 1/27, width: ScreenWidth * 1/27);
    Image full = Image.asset("assets/mango.png",height: ScreenWidth * 1/27, width: ScreenWidth * 1/27);

    if (rating == 0)
      return Row(children: <Widget>[
        Empty,Empty,Empty,Empty,Empty
      ]);
    if (rating == 1)
      return Row(children: <Widget>[
        Empty,Empty,Empty,Empty,full
      ]);
    if (rating == 2)
      return Row(children: <Widget>[
        Empty,Empty,Empty,full,full
      ]);
    if (rating == 3)
      return Row(children: <Widget>[
        Empty,Empty,full,full,full
      ]);
    if (rating == 4)
      return Row(children: <Widget>[
        Empty,full,full,full,full
      ]);
    if (rating == 5)
      return Row(children: <Widget>[
        full,full,full,full,full
      ]);
  }

}