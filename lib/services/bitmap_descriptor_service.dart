import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BitmapDescriptorService {
  Future<Set<Marker>> generateMarkers(List<LatLng> positions) async {
    List<Marker> markers = <Marker>[];
    for (final location in positions) {
      final icon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(24, 24)), 'assets/my_icon.png');

      final marker = Marker(
        markerId: MarkerId(location.toString()),
        position: LatLng(location.latitude, location.longitude),
        icon: icon,
      );

      markers.add(marker);
    }

    return markers.toSet();
  }
}
