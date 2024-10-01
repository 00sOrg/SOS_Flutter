import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapControllerNotifier extends StateNotifier<NaverMapController?> {
  MapControllerNotifier() : super(null);

  Future<void> initializeController(NaverMapController controller) async {
    state = controller; // Set the controller once it's initialized
  }
}

final mapControllerProvider =
    StateNotifierProvider<MapControllerNotifier, NaverMapController?>(
  (ref) => MapControllerNotifier(),
);
