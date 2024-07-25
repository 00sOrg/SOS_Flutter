import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearhere/shared/models/location.dart';
import 'package:nearhere/shared/services/location_service.dart';

final locationProvider = FutureProvider<Location>((ref) async {
  final locationService = LocationService();
  return await locationService.getCurrentLocation();
});
