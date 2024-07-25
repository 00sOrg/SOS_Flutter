import 'package:geolocator/geolocator.dart';

class GeolocatorServices {
  static Future<Position> getCurrentPosition() async {
    // Check for permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return Future.error('Location permissions are permanently denied');
    }

    // When we reach here, permissions are granted, and we can access the position
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}