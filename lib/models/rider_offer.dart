import 'package:flutter/cupertino.dart';

class RiderOffer {
  double price;
  String destination;
  double destinationLat;
  double destinationLng;
  String source;
  num sourceLat;
  num sourceLng;
//  GeoFirePoint myLocation;

  RiderOffer(
      {@required this.price,
      @required this.destination,
      @required this.destinationLat,
      @required this.destinationLng,
      @required this.source,
      @required this.sourceLat,
      @required this.sourceLng}) {
    //Geoflutterfire geo = Geoflutterfire();
    //myLocation = geo.point(latitude: this.sourceLat, longitude: this.sourceLng);
  }

  RiderOffer.fromJson(Map<String, dynamic> parsedJson) {
    price = parsedJson['price'];
    destination = parsedJson['destination'];
    destinationLat = parsedJson['destinationLat'];
    destinationLng = parsedJson['destinationLng'];
    source = parsedJson['source'];
    sourceLat = parsedJson['sourceLat'];
    sourceLng = parsedJson['sourceLng'];
    //Geoflutterfire geo = Geoflutterfire();
    //myLocation = parsedJson["geohash"];
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "destination": destination,
      "destinationLat": destinationLat,
      "destinationLng": destinationLng,
      "source": source,
      "sourceLat": sourceLat,
      "sourceLng": sourceLng,
      //"geohash": myLocation.data,
    };
  }
}
