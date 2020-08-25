import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:mango_rider/models/rider_request.dart';

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
}
