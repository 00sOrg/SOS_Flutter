import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearhere/shared/models/location.dart';
import 'package:nearhere/shared/services/location_service.dart';

class LocationViewModel extends StateNotifier<AsyncValue<Location>> {
  final LocationService _locationService;

  LocationViewModel(this._locationService) : super(const AsyncValue.loading()) {
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      final location = await _locationService.getCurrentLocation();
      state = AsyncValue.data(location);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshLocation() async {
    state = const AsyncValue.loading();
    await _fetchLocation();
  }
}

final locationProvider =
    StateNotifierProvider<LocationViewModel, AsyncValue<Location>>((ref) {
  final locationService = LocationService();
  return LocationViewModel(locationService);
});
