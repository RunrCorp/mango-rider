import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const googleAPIKey = "AIzaSyA7OoEiQjyJd35kPT1NWR8WpvbJS-FpdC8";
const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
LatLng source_location; //= LatLng(42.7477863, -71.1699932);
LatLng dest_location; // = LatLng(42.6871386, -71.2143403);

class ConfirmRidePage extends StatefulWidget {
  num endLat;
  num endLong;

  ConfirmRidePage(@required this.endLat, @required this.endLong) {
    dest_location = LatLng(endLat, endLong);
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      source_location = LatLng(position.latitude, position.longitude);
    }).catchError((e) => print(e));

    print("set source location");
    print(source_location.latitude);
  }
  @override
  _ConfirmRidePageState createState() => _ConfirmRidePageState();
}

class _ConfirmRidePageState extends State<ConfirmRidePage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  void initState() {
    super.initState();
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      source_location = LatLng(position.latitude, position.longitude);
    }).catchError((e) => print(e));
  }

  Widget build(BuildContext context) {
    print(source_location.latitude);
    print(source_location.longitude);
    print("printed for the first time");
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: source_location);
    print(initialLocation.bearing);
    print(source_location.latitude);
    print(source_location.longitude);

    return Scaffold(
      appBar: new AppBar(
        title: Text("Confirm Ride"),
      ),
      body: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          onMapCreated: onMapCreated),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: source_location,
      ));
      // destination pin
      _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: dest_location,
      ));
    });
  }

  setPolylines() async {
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        source_location.latitude,
        source_location.longitude,
        dest_location.latitude,
        dest_location.longitude);
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId('poly'),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }
}
