import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const googleAPIKey = "AIzaSyA7OoEiQjyJd35kPT1NWR8WpvbJS-FpdC8";
const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
LatLng source_location; //= LatLng(42.7477863, -71.1699932);
LatLng dest_location; // = LatLng(42.6871386, -71.2143403);

class ConfirmRidePage extends StatefulWidget {
  num endLat;
  num endLong;

  ConfirmRidePage(@required original_location, @required this.endLat,
      @required this.endLong) {
    source_location = original_location;
    dest_location = LatLng(endLat, endLong);
    print(source_location);
    print("constructor finished");
  }
  @override
  _ConfirmRidePageState createState() => _ConfirmRidePageState();
}

class _ConfirmRidePageState extends State<ConfirmRidePage> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  void initState() {
    print('initializing state');
    super.initState();
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  Widget build(BuildContext context) {
    print("trying to build");
    print(source_location);
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
      key: _scaffoldState,
      appBar: new AppBar(
        title: Text("Confirm Ride"),
      ),
      body: GoogleMap(
          zoomControlsEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          onMapCreated: onMapCreated),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
        ),
        elevation: 20,
        backgroundColor: Colors.white,
        onPressed: () {
          //Scaffold.of(context).showSnackBar(
          //  new SnackBar(content: Text("Ride has been ordered")));

          //var x = new Future.delayed(const Duration(seconds: 1));
          print("showing snackbar");
          _scaffoldState.currentState.showSnackBar(
              new SnackBar(content: new Text("Ride has been ordered")));
          //var y = new Future.delayed(const Duration(seconds: 1));
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).pop();
          });

          //Navigator.of(context).pop();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    mapController = controller;
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: source_location,
        icon: sourceIcon,
      ));
      // destination pin
      _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: dest_location,
        icon: destinationIcon,
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
          color: Theme.of(context).primaryColor,
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
      _setMapFitToTour(_polylines);
    });
  }

  void _setMapFitToTour(Set<Polyline> p) {
    double minLat = p.first.points.first.latitude;
    double minLong = p.first.points.first.longitude;
    double maxLat = p.first.points.first.latitude;
    double maxLong = p.first.points.first.longitude;
    p.forEach((poly) {
      poly.points.forEach((point) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      });
    });
    mapController.moveCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
        20));
  }
}
