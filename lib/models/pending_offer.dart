import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
}

List<PendingOffer> pendingOffers = [
  PendingOffer(
    picture: Image.asset("assets/bagginso.png"),
    driverName: "John Doe",
    rating: 3,
    vehicleName: "Subaru Outback",
    minutesAway: 3,
    cost: 11.11,
  )
];
