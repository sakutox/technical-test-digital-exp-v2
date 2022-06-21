import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:technical_testv2/features/map/data/repositories/change_camera_focus_repository_impl.dart';
import 'package:technical_testv2/features/map/data/repositories/get_location_repository_impl.dart';
import 'package:technical_testv2/features/map/data/repositories/set_current_position_repository_impl.dart';
import 'package:technical_testv2/features/map/domain/repositories/change_camera_focus_repository.dart';
import 'package:technical_testv2/features/map/domain/repositories/get_location_repository.dart';
import 'package:technical_testv2/features/map/domain/repositories/set_current_position_repository.dart';
import 'package:technical_testv2/features/map/domain/use_cases/change_camera_focus.dart';
import 'package:technical_testv2/features/map/domain/use_cases/get_location.dart';
import 'package:technical_testv2/features/map/domain/use_cases/set_current_position.dart';

class MapProvider with ChangeNotifier {
  Marker location = const Marker(
      markerId: MarkerId('xd'), position: LatLng(7.1168123, -73.1074555));

  CameraPosition cameraFocus = const CameraPosition(
    target: LatLng(7.1168123, -73.1074555),
    zoom: 17,
  );

  Position position = Position(
      longitude: -73.1074555,
      latitude: 7.1168123,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  late GoogleMapController googleMapController;

  Future<void> getLocation(Position location2) async {
    GetLocationRepository repository = GetLocationRepositoryImpl(MapProvider());

    await GetLocation(getLocationRepository: repository).call(location2);
    location = Marker(
        markerId: const MarkerId('value'),
        position: LatLng(location2.latitude, location2.longitude));

    notifyListeners();
  }

  Future<void> changeCameraFocus(Position location2) async {
    ChangeCameraFocusRepository repository =
        ChangeCameraFocusRepositoryImpl(MapProvider());

    await ChangeCameraFocus(changeCameraFocusRepository: repository)
        .call(location2);

    cameraFocus = CameraPosition(
      target: LatLng(location2.latitude, location2.longitude),
      zoom: 17,
    );

    await googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraFocus));

    notifyListeners();
  }

  determinePosition(MapProvider mapProvider) async {
    bool serviceEnabled;
    LocationPermission permission;

    SetCurrentPositionRepository repository =
        SetCurrentPositionRepositoryImpl(MapProvider());

    await SetCurrentPosition(setCurrentPositionRepository: repository)
        .call(mapProvider);

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      mapProvider.getLocation(await Geolocator.getCurrentPosition());
      mapProvider.changeCameraFocus(await Geolocator.getCurrentPosition());
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }
}
