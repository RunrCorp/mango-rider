import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  final geo = Geolocator();

  Future<Position> getCoords() async {
    return await geo.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  Future<List<Placemark>> getAddrees(Position position) async {
    return await geo.placemarkFromCoordinates(
        position.latitude, position.longitude);
  }

  Stream<Position> trackLocation() {
    return geo.getPositionStream(
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10));
  }
}
