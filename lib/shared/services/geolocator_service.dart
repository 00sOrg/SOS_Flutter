import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  static Future<Position> getCurrentPosition(
      {LocationAccuracy accuracy = LocationAccuracy.high}) async {
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
    return await Geolocator.getCurrentPosition(desiredAccuracy: accuracy);
  }

  // Get the last known position stored on the device
  static Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  // Listen to location updates
  static Stream<Position> getPositionStream(
      {LocationAccuracy accuracy = LocationAccuracy.high,
      int distanceFilter = 100}) {
    final LocationSettings locationSettings =
        LocationSettingsConfig.getPlatformLocationSettings();
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  // Check if location services are enabled
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Check the current location permission status
  static Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  // Request location permissions
  static Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  static Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  // Get location accuracy status (iOS 14+ and Android only)
  static Future<LocationAccuracyStatus> getLocationAccuracy() async {
    return await Geolocator.getLocationAccuracy();
  }

  // Listen to location service status changes
  static Stream<ServiceStatus> getServiceStatusStream() {
    return Geolocator.getServiceStatusStream();
  }
}

class LocationSettingsConfig {
  static LocationSettings getPlatformLocationSettings() {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      return AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: false,
        showBackgroundLocationIndicator: true,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText: "App is tracking your location in the background.",
          notificationTitle: "Background Location Tracking",
          enableWakeLock: true,
        ),
      );
    } else {
      return LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }
  }
}

//// Platform Specific Location Settings
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator_apple/geolocator_apple.dart';

// final LocationSettings locationSettings = AppleSettings(
//   accuracy: LocationAccuracy.high,
//   activityType: ActivityType.fitness,
//   distanceFilter: 100,
//  pauseLocationUpdatesAutomatically: false,  // Ensure updates continue in the background
//  showBackgroundLocationIndicator: true,    // Show indicator in the background
// );

// StreamSubscription<Position> positionStream =
//     Geolocator.getPositionStream(locationSettings: locationSettings).listen(
//   (Position? position) {
//     if (position != null) {
//       print('Position: ${position.latitude}, ${position.longitude}');
//     } else {
//       print('Unknown position');
//     }
//   },
//   onError: (error) {
//     print('Error: $error');
//   },
//   onDone: () {
//     print('Stream closed');
//   },
// );
