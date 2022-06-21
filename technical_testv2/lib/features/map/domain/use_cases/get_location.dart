import 'package:geolocator/geolocator.dart';

import '../repositories/get_location_repository.dart';

class GetLocation {
  GetLocationRepository getLocationRepository;

  GetLocation({required this.getLocationRepository});

  Future<void> call(Position position) async {
    getLocationRepository.getLocation(position);
  }
}
