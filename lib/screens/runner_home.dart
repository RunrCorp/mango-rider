//import 'package:camera/camera.dart';
import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mango/models/location.dart';
import 'package:mango/screens/confirm_ride.dart';
import 'package:mango/screens/order_history.dart';
import 'package:mango/screens/settings.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'current_offers.dart';

class HomePage extends StatefulWidget {
//  final List<CameraDescription> cameras;
//  HomePage({this.cameras});

  final FirebaseUser _user;

  HomePage(this._user);

  @override
  _HomePageState createState() => new _HomePageState(_user);
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  GoogleMapController mapController;
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "AIzaSyA7OoEiQjyJd35kPT1NWR8WpvbJS-FpdC8");

  LatLng source_location;
  LatLng _center = LatLng(40, -74);
  final FirebaseUser _user;

  _HomePageState(this._user);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setMapPins();
    print("When the map was created:");
    print(_center);
  }

  @override
  void initState() {
    super.initState();
    _setSourceLocation();
  }

  String currentProfilePicture = "";

  String otherProfilePicture =
      "http://www.jacklee.us/static/media/potato.7dedc136.png";

  void editPicture() {
    print("Tapped here to edit picture!");
    String temp = currentProfilePicture;
    setState(() {
      currentProfilePicture = otherProfilePicture;
      otherProfilePicture = temp;
    });
  }

  Widget _buildSuggestions() {
    List<RunnerLocation> locations = _getRecentLocations();
    return new ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset('assets/prediction_pin.png'),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, .22), width: 2)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(3),
                    title: Text(
                      locations[index].streetAddress,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      locations[index].city +
                          ", " +
                         locations[index].state +
                         " " +
                         locations[index].zipCode,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  List<RunnerLocation> _getRecentLocations() {
    print("Getting recent locations");
    return [
      new RunnerLocation(
          streetAddress: "546 Brook Ave",
          city: "River Vale",
          state: "New Jersey",
          zipCode: "07675"),
      new RunnerLocation(
          streetAddress: "74 Stratford Rd",
          city: "Dumont",
          state: "NJ",
          zipCode: "82634"),
      new RunnerLocation(
          streetAddress: "1007 Mountain Drive",
          city: "Gotham",
          state: "NJ",
          zipCode: "2187"),
    ];
  }

  PanelController _panelController = new PanelController();
  TextEditingController _textEditingController = new TextEditingController();

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    print("building page");
    print("center: ");
    print(_center);
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
      floatingActionButton: new Builder(builder: (context) {
        return new Container(
            margin: const EdgeInsets.only(top: 150.0),
            child: new FloatingActionButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
                FocusScope.of(context).unfocus();
              },
              child: const Icon(Icons.menu),
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).primaryColor,
            ));
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      endDrawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(_user.displayName),
              accountEmail: new Text(_user.email),
              currentAccountPicture: new GestureDetector(
                onTap: editPicture,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(_user.photoUrl),
                ),
              ),
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            new ListTile(
                title: new Text("Past Orders"),
                trailing: new Icon(Icons.timelapse),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new OrderHistoryPage()));
                }),
            new ListTile(
                title: new Text("Current Offers"),
                trailing: Badge(
                  child: Icon(Icons.inbox),
                  badgeColor: Colors.red,
                  badgeContent:
                      Text("3", style: TextStyle(color: Colors.white)),
                  elevation: 2,
                  shape: BadgeShape.circle,
                  position: BadgePosition.topRight(),
                ), //new Icon(Icons.inbox),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new OffersPage()));
                }),
            new ListTile(
                title: new Text("Settings"),
                trailing: new Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new SettingsPage()));
                }),
            new Divider(),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: SlidingUpPanel(
        controller: _panelController,
        minHeight: 95,
        maxHeight: 400,

        //header: new Container(
        //color: Colors.black,
        //  child: new TextField(),
        //),
        panel: Container(
          padding: const EdgeInsets.fromLTRB(20, 11, 20, 20),
          child: Column(children: <Widget>[
            //could replace with a vector here?
            Image.asset("assets/pullup_rectangle.png", width: 47, height: 8),
            Container(
              padding: const EdgeInsets.only(top: 12),
              height: 49,
              child: TextField(
                controller: _textEditingController,
                onTap: () async {
                  //_panelController.open();
                  print("on tap function entered");
                  // show input autocomplete with selected mode
                  // then get the Prediction selected
                  //AIzaSyAv3aGyislLlmnTLeL0O_ub-2IqilWke9Q
                  Prediction p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: "AIzaSyA7OoEiQjyJd35kPT1NWR8WpvbJS-FpdC8",
                    radius: 10000000,
                    onError: (response) => print(response.errorMessage),
                  );
                  print(
                      "Prediction has been received, now displaying prediction");
                  displayPrediction(p);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    icon: Icon(Icons.navigation,
                        color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(t),
                      ),
                    ),
                    fillColor: Color.fromRGBO(234, 234, 234, 1),
                    filled: true,
                    hintText: "Where to?",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    )),
              ),
            ),
            Flexible(
              child: _buildSuggestions(),
            ),
          ]),
        ),
//        collapsed: Container(
//          child: Center(r
//            child: Text(
//              "Hey ${_user.displayName}!",
//              style: TextStyle(fontSize: 30),
//            ),
//          ),
//        ),
        body: GoogleMap(
          onTap: (_) {
            FocusScope.of(context).unfocus();
            if (_panelController.isPanelOpen) {
              _panelController.close();
            }
          },
          zoomControlsEnabled: true,
          myLocationButtonEnabled: true,
          markers: _markers,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
        ),
        borderRadius: radius,
      ),
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    print("Displaying Prediction");
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ConfirmRidePage(source_location, lat, lng)));
      print(address);
      print("\n\n\\nn\n\n\n\n\n\n\n\n\n\n\n\n\n");
      print(lat);
      print(lng);
    }
  }

  void _setSourceLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      source_location = LatLng(position.latitude, position.longitude);
      _center = source_location;
      mapController.moveCamera(CameraUpdate.newLatLng(_center));
      setState(() {
        _markers = {
          Marker(
            markerId: MarkerId('sourcePin'),
            position: source_location,
          )
        };
      });
    }).catchError((e) => print(e));
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: _center,
      ));
      // destination pin
    });
  }
}
