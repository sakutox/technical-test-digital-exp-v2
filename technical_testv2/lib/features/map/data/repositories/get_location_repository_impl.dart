import 'dart:developer';

import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:technical_testv2/features/map/display/providers/map_provider.dart';
import 'package:technical_testv2/features/map/domain/repositories/get_location_repository.dart';

class GetLocationRepositoryImpl implements GetLocationRepository {
  MapProvider mapProvider;
  GetLocationRepositoryImpl(this.mapProvider);

  @override
  Future<void> getLocation(Position position) async {
    try {
      mapProvider.getLocation(position);
    } catch (e) {
      log('error con get location repository impl: $e');
    }
  }
}
