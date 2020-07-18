import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiderOffer {
  double price;
  double destinationLat;
  double destinationLng;
  double sourceLat;
  double sourceLng;

  RiderOffer(
      {@required this.price,
      @required this.destinationLat,
      @required this.destinationLng,
      @required this.sourceLat,
      @required this.sourceLng});

  RiderOffer.fronJson(Map<String, dynamic> parsedJson) {
    price = parsedJson['price'];
    destinationLat = parsedJson['destinationLat'];
    destinationLng = parsedJson['destinationLng'];
    sourceLat = parsedJson['sourceLat'];
    sourceLng = parsedJson['sourceLng'];
  }

  Map<String, dynamic> offerToJson() {
    return {
      "price": price,
      "destinationLat": destinationLat,
      "destinationLng": destinationLng,
      "sourceLat": sourceLat,
      "sourceLng": sourceLng,
    };
  }
}
