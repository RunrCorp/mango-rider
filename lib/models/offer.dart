import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Offer {
  double price;
  LatLng destination;
  LatLng currentPosition;

  Offer(
      {@required this.price,
      @required this.destination,
      @required this.currentPosition});
}
