import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiderOffer {
  double price;
  LatLng destination;
  LatLng currentPosition;

  RiderOffer(
      {@required this.price,
      @required this.destination,
      @required this.currentPosition});
}
