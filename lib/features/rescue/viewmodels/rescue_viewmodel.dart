import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/enums/status_enum.dart';
import 'package:sos/shared/models/friend.dart';

class RescueViewModel extends StateNotifier<List<Friend>> {
  RescueViewModel() : super([]) {
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    List<Friend> dummyFriends = [
      Friend(id: 1, name: '엄마', status: FriendStatus.friend),
      Friend(id: 2, name: '아빵', status: FriendStatus.friend),
      Friend(id: 3, name: '친구1', status: FriendStatus.friend),
    ];

    // 상태 업데이트
    state = dummyFriends;
  }

  void handleNearbyAlert() {
    log("HANDLE NEARBY ALERT");
  }

  void handleEmergencyAlert() {
    log("HANDLE EMERGENCY ALERT");
  }
}

final rescueViewModelProvider =
    StateNotifierProvider<RescueViewModel, List<Friend>>(
  (ref) => RescueViewModel(),
);
