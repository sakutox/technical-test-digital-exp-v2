import 'package:geolocator/geolocator.dart';

import '../repositories/change_camera_focus_repository.dart';

class ChangeCameraFocus {
  ChangeCameraFocusRepository changeCameraFocusRepository;

  ChangeCameraFocus({required this.changeCameraFocusRepository});

  Future<void> call(Position position) async {
    changeCameraFocusRepository.changeCameraFocus(position);
  }
}
