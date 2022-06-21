

import 'package:geolocator/geolocator.dart';

abstract class ChangeCameraFocusRepository {
  Future<void> changeCameraFocus(Position position);
}
