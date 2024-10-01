import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/location.dart';
import 'package:sos/shared/services/geolocator_service.dart';
import 'package:sos/shared/services/location_service.dart';

class LocationViewModel extends StateNotifier<AsyncValue<Location>> {
  final LocationService _locationService;

  LocationViewModel(this._locationService) : super(const AsyncValue.loading()) {
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      final position = await GeolocatorService.getCurrentPosition();
      final lat = position.latitude;
      final lon = position.longitude;

      final jsonData = await _locationService.fetchLocationData(lat, lon);

      final adminAddress = _extractAdminAddress(jsonData); // "시, 구"
      final roadAddress = _extractRoadAddress(jsonData); // "시, 구, 동"

      if (adminAddress.isEmpty || roadAddress.isEmpty) {
        throw RangeError("주소를 찾을 수 없습니다");
      }

      state = AsyncValue.data(
        Location(
          latitude: lat,
          longitude: lon,
          adminAddress: adminAddress,
          roadAddress: roadAddress,
        ),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshLocation() async {
    state = const AsyncValue.loading();
    await _fetchLocation();
  }

  // "member 마지막 위치는 lat, lng 값만 주면 되지?" 에 해당하는 함수임요
  Future<String> getRoadAddressFromCoords(double lat, double lon) async {
    try {
      final jsonData = await _locationService.fetchLocationData(lat, lon);

      final roadAddress = _extractRoadAddress(jsonData);

      if (roadAddress.isEmpty) {
        throw RangeError(
          "getRoadAddressFromCoords: 해당 좌표에 대한 도로명 주소를 찾을 수 없습니다",
        );
      }

      return roadAddress;
    } catch (error) {
      throw Exception("getRoadAddressFromCoords 에러: $error");
    }
  }

  // "시, 구, 동"
  String _extractRoadAddress(Map<String, dynamic> jsonData) {
    for (var result in jsonData["results"]) {
      if (result["name"] == "roadaddr") {
        return result["region"]["area1"]["name"] +
            ' ' +
            result["region"]["area2"]["name"] +
            ' ' +
            result["region"]["area3"]["name"];
      }
    }
    return _extractAdminAddress(jsonData);
  }

  // "시, 구"
  String _extractAdminAddress(Map<String, dynamic> jsonData) {
    for (var result in jsonData["results"]) {
      if (result["name"] == "addr") {
        return result["region"]["area1"]["name"] +
            ' ' +
            result["region"]["area2"]["name"];
      }
    }
    return '';
  }
}

final locationViewModelProvider =
    StateNotifierProvider<LocationViewModel, AsyncValue<Location>>((ref) {
  final locationService = LocationService();
  return LocationViewModel(locationService);
});
