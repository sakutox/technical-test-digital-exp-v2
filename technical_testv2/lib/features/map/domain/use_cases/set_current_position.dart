import 'package:technical_testv2/features/map/display/providers/map_provider.dart';

import '../repositories/set_current_position_repository.dart';

class SetCurrentPosition {
  SetCurrentPositionRepository setCurrentPositionRepository;

  SetCurrentPosition({required this.setCurrentPositionRepository});

  Future<void> call(MapProvider mapProvider) async {
    setCurrentPositionRepository.setCurrentPosition(mapProvider);
  }
}
