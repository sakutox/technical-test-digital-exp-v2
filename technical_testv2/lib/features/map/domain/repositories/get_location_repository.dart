import 'package:geolocator/geolocator.dart';

abstract class GetLocationRepository {
  Future<void> getLocation(Position position);
}
