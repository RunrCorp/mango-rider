import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:mango/models/rider_offer.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> addRiderOffer(RiderOffer initialOffer) async {
    print("adding offer");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'addRiderOffer',
    );
    dynamic resp = await callable.call(initialOffer.toJson());
    print("print response:");
    print(resp);
    print(resp.runtimeType);
  }
}
