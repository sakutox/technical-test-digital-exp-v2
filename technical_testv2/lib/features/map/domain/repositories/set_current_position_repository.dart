import 'package:technical_testv2/features/map/display/providers/map_provider.dart';

abstract class SetCurrentPositionRepository {
  Future<void> setCurrentPosition(MapProvider mapProvider);
}
