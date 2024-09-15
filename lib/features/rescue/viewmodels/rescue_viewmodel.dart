import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/enums/status_enum.dart';
import 'package:sos/shared/models/friend.dart';

class RescueViewModel extends StateNotifier<List<Friend>> {
  RescueViewModel() : super([]) {
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    List<Friend> dummyFriends = [
      Friend(id: 1, name: '엄마', status: FriendStatus.friend),
      // Friend(id: 2, name: '일이삼사오육칠팔구십일이삼사오육', status: FriendStatus.friend),
      // Friend(id: 3, name: '친구1', status: FriendStatus.friend),
      // Friend(id: 4, name: '친구22222', status: FriendStatus.friend),
    ];

    // 상태 업데이트
    state = dummyFriends;
  }

  void handleFriendHelp({
    required int id,
    required String name,
  }) {
    log('HANDLE FRIEND HELP: $name');
  }

  void handleFriendAdd(BuildContext context) {
    log("HANDLE ADD FRIEND");
    GoRouter.of(context).push('/setting-favorite-search');
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
