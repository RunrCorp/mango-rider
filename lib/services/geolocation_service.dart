import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart'; // flutter_config
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocatorService {
  final geo = Geolocator();

  final googleAPIKey =
      FlutterConfig.get('GOOGLE_MAPS_API_KEY'); // flutter_config

  Future<Position> getCoords() async {
    return await geo.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  Future<List<Placemark>> getAddress(Position position) async {
    return await geo.placemarkFromCoordinates(
        position.latitude, position.longitude);
  }

//  Future<List<Placemark>> getTwoAddresses(
//      Position positionOne, Position positionTwo) async {
//    List<Placemark> firstAddress = await geo.placemarkFromCoordinates(
//        positionOne.latitude, positionOne.longitude);
//    Placemark address = firstAddress[0];
//    List<Placemark> secondAddress = await geo.placemarkFromCoordinates(
//        positionTwo.latitude, positionTwo.longitude);
//    Placemark destination = secondAddress[0];
//    return [address, destination];
//  }

  Stream<Position> trackLocation() {
    return geo.getPositionStream(
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10));
  }

  Future<Set<Polyline>> setPolylines(source_location, dest_location) async {
    print("setting polylines");
    Set<Polyline> _polylines = {};
    List<LatLng> polylineCoordinates = [];
    final polylinePoints = PolylinePoints();
    print("created polyline points");
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        source_location.latitude,
        source_location.longitude,
        dest_location.latitude,
        dest_location.longitude);

    print("got result variable");
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    Polyline polyline = Polyline(
        polylineId: PolylineId('poly'),
        color: Colors.red,
        points: polylineCoordinates);

    print("created polyline");

    _polylines.add(polyline);
    print("polylines set");
    return _polylines;
    //_setMapFitToTour(_polylines);
  }
}
