import 'package:flutter/cupertino.dart';
import 'package:mango_rider/models/pending_offer_db.dart';

class PendingOffer {
  Image picture;
  String driverName;
  double rating;
  String vehicleName;
  int minutesAway;
  double cost;

  bool isExpanded;

  PendingOffer({
    @required this.picture,
    @required this.driverName,
    @required this.rating,
    @required this.vehicleName,
    @required this.minutesAway,
    @required this.cost,
    this.isExpanded = false,
  });

  PendingOffer.fromPendingOfferDb(PendingOfferDb offer) {
    //picture = Image.network(offer.driverImage);
    picture = Image.asset("assets/bagginso.png");
    driverName = offer.driverName;
    rating = 0;
    vehicleName = "idk subaru maybe";
    minutesAway = 5; //this is going to be a predicament
    cost = offer.price;


  }
}

/*
List<PendingOffer> pendingOffers = [
  PendingOffer(
    picture: Image.asset("assets/bagginso.png"),
    driverName: "Bilbo",
    rating: 3,
    vehicleName: "Subaru Outback",
    minutesAway: 3,
    cost: 3.45,
  ),
  PendingOffer(
    picture: Image.asset("assets/marlo.png"),
    driverName: "Robert",
    rating: 5,
    vehicleName: "Lamborghini Huracan",
    minutesAway: 4,
    cost: 4.20,
  ),
  PendingOffer(
    picture: Image.asset("assets/elfo.png"),
    driverName: "Gnome",
    rating: 2,
    vehicleName: "Honda Civic",
    minutesAway: 2,
    cost: 109.22,
  ),
  PendingOffer(
    picture: Image.asset("assets/marlo.png"),
    driverName: "Viral Patel",
    rating: 1.2,
    vehicleName: "Laborghini Huracan",
    minutesAway: 4,
    cost: 22.22,
  ),
  PendingOffer(
    picture: Image.asset("assets/elfo.png"),
    driverName: "Ron Samuel",
    rating: 4.8,
    vehicleName: "Honda Civic",
    minutesAway: 2,
    cost: 15.22,
  ),
  PendingOffer(
    picture: Image.asset("assets/bagginso.png"),
    driverName: "Bilbo",
    rating: 3,
    vehicleName: "Subaru Outback",
    minutesAway: 3,
    cost: 3.45,
  ),
  PendingOffer(
    picture: Image.asset("assets/marlo.png"),
    driverName: "Robert",
    rating: 5,
    vehicleName: "Lamborghini Huracan",
    minutesAway: 4,
    cost: 4.20,
  ),
  PendingOffer(
    picture: Image.asset("assets/elfo.png"),
    driverName: "Gnome",
    rating: 2,
    vehicleName: "Honda Civic",
    minutesAway: 2,
    cost: 109.22,
  ),
];
*/