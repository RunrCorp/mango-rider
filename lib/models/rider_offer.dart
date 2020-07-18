import 'package:flutter/cupertino.dart';

class RiderOffer {
  double price;
  String destination;
  double destinationLat;
  double destinationLng;
  String source;
  double sourceLat;
  double sourceLng;

  RiderOffer(
      {@required this.price,
      @required this.destination,
      @required this.destinationLat,
      @required this.destinationLng,
      @required this.source,
      @required this.sourceLat,
      @required this.sourceLng});

  RiderOffer.fronJson(Map<String, dynamic> parsedJson) {
    price = parsedJson['price'];
    destination = parsedJson['destination'];
    destinationLat = parsedJson['destinationLat'];
    destinationLng = parsedJson['destinationLng'];
    source = parsedJson['source'];
    sourceLat = parsedJson['sourceLat'];
    sourceLng = parsedJson['sourceLng'];
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "destination" : destination,
      "destinationLat": destinationLat,
      "destinationLng": destinationLng,
      "source" : source,
      "sourceLat": sourceLat,
      "sourceLng": sourceLng,
    };
  }
}
