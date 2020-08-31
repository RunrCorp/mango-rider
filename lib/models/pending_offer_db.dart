import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PendingOfferDb {
  String destination;
  num destinationLat;
  num destinationLng;
  num price;
  String source;
  num sourceLat;
  num sourceLng;
  String riderUid;
  String riderName;
  //String riderImage;
  //double riderRating;
  Timestamp timestamp;
  String driverUid; //could leave out
  String driverName; //could leave out
  //String driverImage;
  //double driverRating;
  //String vehicleName;
  //int minutesAway;
  String initialOfferId;
  bool acceptedByDriver; //could leave out
  bool acceptedByRider; //could leave out
  bool accepted; //could leave out
  bool currentOffer; //could leave out
  int numberOffer;

  PendingOfferDb(
      {@required this.destination,
      @required this.destinationLat,
      @required this.destinationLng,
      @required this.price,
      @required this.source,
      @required this.sourceLat,
      @required this.sourceLng,
      @required this.riderUid,
      @required this.riderName,
      //@required this.riderImage,
      //@required this.riderRating,
      @required this.driverName,
      //@required this.driverImage,
      //@required this.driverRating;
      //@required this.vehicleName;
      //@required this.minutesAway;
      @required this.driverUid,
      @required this.initialOfferId});

  PendingOfferDb.fromJson(Map<String, dynamic> data)
      : destination = data["destination"],
        destinationLat = data["destinationLat"],
        destinationLng = data["destinationLng"],
        price = data["price"],
        source = data["source"],
        sourceLat = data["sourceLat"],
        sourceLng = data["sourceLng"],
        riderUid = data["riderUid"],
        riderName = data["riderName"],
        //riderImage = data["riderImage"],
        //riderRating = data["riderRating"],
        driverUid = data["driverUid"],
        driverName = data["driverName"],
        //driverImage = data["driverImage"],
        //driverRating = data["driverRating"],
        //vehicleName = data["vehicleName"],
        //minutesAway = data["minutesAway"],
        timestamp = data["timestamp"],
        initialOfferId = data["initialOfferId"],
        numberOffer = data["numberOffer"];

  Map<String, dynamic> toInitialJson() {
    return {
      "destination": destination,
      "destinationLat": destinationLat,
      "destinationLng": destinationLng,
      "price": price,
      "source": source,
      "sourceLat": sourceLat,
      "sourceLng": sourceLng,
      "riderUid": riderUid,
      "riderName": riderName,
      //"riderImage": riderImage,
      //"riderRating": riderRating,
      "driverUid": driverUid,
      "driverName": driverName,
      //"driverImage": driverImage,
      //"driverRating": driverRating,
      //"vehicleName": vehicleName,
      //"minutesAway": minutesAway,
      "initialOfferId": initialOfferId,
    };
  }
}
