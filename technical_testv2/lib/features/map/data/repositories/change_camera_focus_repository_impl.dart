import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:technical_testv2/features/map/domain/repositories/change_camera_focus_repository.dart';

import '../../display/providers/map_provider.dart';

class ChangeCameraFocusRepositoryImpl implements ChangeCameraFocusRepository {
  MapProvider mapProvider;
  ChangeCameraFocusRepositoryImpl(this.mapProvider);

  @override
  Future<void> changeCameraFocus(Position position) async {
    try {
      mapProvider.changeCameraFocus(position);
    } catch (e) {
      log('error on change camera focus: $e');
    }
  }
}
