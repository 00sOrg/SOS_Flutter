import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/enums/status_enum.dart';
import 'package:sos/shared/models/friend.dart';

class RescueViewModel extends StateNotifier<List<Friend>> {
  RescueViewModel() : super([]);

  // 서버나 로컬에서 친구 목록을 가져오는 함수
  Future<void> fetchFriends() async {
    // 서버에서 가져온 친구 목록을 가정
    List<Friend> friendsFromServer = [
      Friend(id: 1, name: '엄마', status: FriendStatus.friend),
      Friend(id: 2, name: '아빠', status: FriendStatus.friend),
      Friend(id: 3, name: '친구1', status: FriendStatus.friend),
    ];

    // 친구 목록이 4명 미만일 경우 빈 자리 -1 ID로 채우기
    List<Friend> limitedFriends = friendsFromServer.take(4).toList();
    while (limitedFriends.length < 4) {
      limitedFriends.add(Friend(id: -1, name: '빈 자리'));
    }

    // 상태 업데이트
    state = limitedFriends;
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
