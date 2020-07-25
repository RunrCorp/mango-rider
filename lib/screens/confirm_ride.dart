import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mango/models/rider_offer.dart';
import 'package:mango/services/geolocation_service.dart';
import 'package:provider/provider.dart';

// const googleAPIKey = "";
const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
// = LatLng(42.6871386, -71.2143403);

class ConfirmRidePage extends StatefulWidget {
  num endLat;
  num endLong;
  Address endingAddress;
  LatLng source_location; //= LatLng(42.7477863, -71.1699932);
  LatLng dest_location;

  ConfirmRidePage(@required original_location, @required this.endLat,
      @required this.endLong, this.endingAddress) {
    source_location = original_location;
    dest_location = LatLng(endLat, endLong);
    print(source_location);
    print("constructor finished");
  }

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

  final GeoLocatorService geoLocatorService = GeoLocatorService();

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  String confirmSource;
  String confirmDestination;
  double price;
  TextEditingController _textControllerSource =
      new TextEditingController(text: 'Initial value');
  TextEditingController _textControllerDestination =
      new TextEditingController(text: 'Initial value');
  TextEditingController _textControllerPrice =
      new TextEditingController(text: 'Initial value');

  void initState() {
    print('initializing state');
    super.initState();
    setSourceAndDestinationIcons();
    _textControllerSource = new TextEditingController(text: 'Initial value');
    _textControllerDestination =
        new TextEditingController(text: 'Initial value');
    _textControllerPrice = new TextEditingController(text: 'Initial value');
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  void userConfirmRide() async {
    confirmSource = _textControllerSource.text;
    confirmDestination = _textControllerDestination.text;
    price = double.parse(_textControllerPrice.text);

    //RiderOffer userInitialOffer = RiderOffer(price: price, )

    _scaffoldState.currentState
        .showSnackBar(new SnackBar(content: new Text("Ride has been ordered")));
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pop();
    });
    //Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: widget.source_location);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldState,
      appBar: new AppBar(
        title: Text("Confirm Ride"),
      ),
      body: FutureProvider<List<Placemark>>(
        create: (_) => geoLocatorService.getAddress(
          Position(
              latitude: widget.source_location.latitude,
              longitude: widget.source_location.longitude),
        ),
        child: Consumer<List<Placemark>>(
          builder: (_, value, __) {
            Placemark startingAddress = (value != null) ? value[0] : null;
            //Placemark endingAddress = (value != null) ? value[1] : null;
            // _textControllerOne = TextEditingController(
            //     text: (startingAddress == null)
            //         ? ""
            //         : placemarkToString(startingAddress));
            // _textControllerTwo = TextEditingController(
            //     text: addressToString(widget.endingAddress));

            return Column(
              children: [
                TextField(
                  controller: _textControllerSource,
                  decoration: InputDecoration(hintText: "Starting Location"),
                ),
                TextField(
                  controller: _textControllerDestination,
                  decoration: InputDecoration(hintText: "Destination"),
                ),
                TextField(
                  controller: _textControllerPrice,
                  decoration: InputDecoration(hintText: "Initial Offer Price"),
                ),
                FutureProvider<Set<Polyline>>(create: (_) {
                  print('CALLING FUTURE');
                  return geoLocatorService.setPolylines(
                      widget.source_location, widget.dest_location);
                }, child: Consumer<Set<Polyline>>(builder: (_, value, __) {
                  print("Entered consumer");
                  print(value);
                  Widget map = SizedBox(
                      height: 500,
                      child: GoogleMap(
                          zoomControlsEnabled: true,
                          myLocationEnabled: true,
                          compassEnabled: true,
                          tiltGesturesEnabled: false,
                          markers: _markers,
                          polylines: value,
                          mapType: MapType.normal,
                          initialCameraPosition: initialLocation,
                          onMapCreated: onMapCreated));
                  if (value != null) {
                    _setMapFitToTour(value);
                  }
                  return map;
                }))
              ],
            );
          },
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 32.0),
        child: FloatingActionButton(
          child: Icon(Icons.check, color: Theme.of(context).primaryColor),
          elevation: 20,
          backgroundColor: Colors.white,
          onPressed: userConfirmRide,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    mapController = controller;

    setMapPins();
//    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: widget.source_location,
        icon: sourceIcon,
      ));
      // destination pin
      _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: widget.dest_location,
        icon: destinationIcon,
      ));
    });
  }

  void _setMapFitToTour(Set<Polyline> p) {
    if (p.isEmpty || mapController == null) {
      return;
    }
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
        25));
  }

  String placemarkToString(Placemark address) {
    return address.name +
        " " +
        address.thoroughfare +
        ", " +
        address.locality +
        ", " +
        // address.country +
        address.administrativeArea;
//        Address dest = Address(
//          coordinates: Coordinates(address.position.latitude, address.position.longitude)
//        );
//        ", " +
//        address.postalCode;
  }

  String addressToString(Address address) {
    return //address. +
        //", " +
        address.addressLine +
            address.thoroughfare +
            ", " +
            address.locality +
            ", " +
            address.postalCode;
  }
}
