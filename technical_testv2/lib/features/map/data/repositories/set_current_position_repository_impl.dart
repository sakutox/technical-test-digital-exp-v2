import 'dart:developer';

import 'package:technical_testv2/features/map/domain/repositories/set_current_position_repository.dart';

import '../../display/providers/map_provider.dart';

class SetCurrentPositionRepositoryImpl implements SetCurrentPositionRepository {
  MapProvider mapProvider;
  SetCurrentPositionRepositoryImpl(this.mapProvider);

  @override
  Future<void> setCurrentPosition(MapProvider mapProvider) async {
    try {
      mapProvider.determinePosition(mapProvider);
    } catch (e) {
      log('error on set current position repository impl: $e');
    }
  }
}
