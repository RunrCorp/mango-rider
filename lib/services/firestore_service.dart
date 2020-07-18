
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mango/models/rider_offer.dart';

class FirestoreService {

  Firestore _db = Firestore.instance;

  Future<void> addRiderOffer(RiderOffer initialOffer) {
    return _db.collection('riderOffers').add(initialOffer.toJson());
  }

}