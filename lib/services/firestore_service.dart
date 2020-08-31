import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:mango_rider/models/rider_request.dart';
import 'package:mango_rider/models/pending_offer.dart';
import 'package:mango_rider/models/pending_offer_db.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> addRiderRequest(
      RiderRequest initialRequest, BuildContext context) async {
    print("adding request");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'addRiderRequest',
    );
    callable.call(initialRequest.toJson()).then((resp) {
      print("print response:");
      print(resp);
      print(resp.runtimeType);
    }).catchError((err) {
      print(err);
    });
//    dynamic resp = await callable.call(initialOffer.toJson());
//    print("print response:");
//    print(resp);
//    print(resp.runtimeType);
  }

  Future<void> acceptDriverOffer(
      PendingOfferDb acceptedOffer, BuildContext context) async { // TODO: Add transactions capability
    print("accepting offer");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'acceptDriverOffer',
    );
    callable.call(acceptedOffer).then((resp) {
      print("print response:");
      print(resp);
      print(resp.runtimeType);
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<PendingOfferDb>> getDriverOffers() async {

    print("getting driver offers");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getDriverOffers',
    );

    var resp = await callable.call();

    List<PendingOfferDb> driverOffers = [];

    for (int i = 0; i < resp.data.length; i++) {
      var documentData = resp.data[i]["documentData"];
      PendingOfferDb offer = PendingOfferDb.fromJson(documentData);
      driverOffers.add(offer);
    }

    return driverOffers;
  }
}
