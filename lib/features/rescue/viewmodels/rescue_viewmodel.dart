import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RescueViewModel extends StateNotifier<void> {
  RescueViewModel() : super(null);

  void handleNearbyAlert() {
    log("HANDLE NEARBY ALERT");
  }

  void handleEmergencyAlert() {
    log("HANDLE EMERGENCY ALERT");
  }
}

final rescueViewModelProvider = StateNotifierProvider<RescueViewModel, void>(
  (ref) => RescueViewModel(),
);
