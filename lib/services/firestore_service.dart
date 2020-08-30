import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:mango_rider/models/pending_offer.dart';
import 'package:mango_rider/models/rider_offer.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> addRiderOffer(
      RiderOffer initialOffer, BuildContext context) async {
    print("adding offer");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'addRiderOffer',
    );
    callable.call(initialOffer.toJson()).then((resp) {
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
      PendingOffer acceptedOffer, BuildContext context) async { // TODO: Add transactions capability
    print("accepting offer");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'acceptDriverOffer',
    );
    callable.call(acceptedOffer.toJson()).then((resp) {
      print("print response:");
      print(resp);
      print(resp.runtimeType);
    }).catchError((err) {
      print(err);
    });
  }
}
