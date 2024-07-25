import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/location.dart';
import 'package:sos/shared/services/location_service.dart';

final locationProvider = FutureProvider<Location>((ref) async {
  final locationService = LocationService();
  return await locationService.getCurrentLocation();
});
