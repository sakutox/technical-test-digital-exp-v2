import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyProvider with ChangeNotifier {
  int number = 0;
  Marker location = Marker(
      markerId: MarkerId('xd'), position: LatLng(7.1168123, -73.1074555));

  void myFunction() {
    number++;
    notifyListeners();
  }

  void getLocation(Position location2) {

    location = Marker(
        markerId: MarkerId('value'),
        position: LatLng(location2.latitude, location2.longitude));

    notifyListeners();
  }
}
