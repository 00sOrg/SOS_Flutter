import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/providers/friend_repository_provider.dart';
import 'package:sos/shared/repositories/friends_repository.dart';
import 'package:sos/shared/services/geolocator_service.dart';

class RescueViewModel extends StateNotifier<List<Friend>> {
  final FriendsRepository friendsRepository;

  RescueViewModel(this.friendsRepository) : super([]) {
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    final friends = await friendsRepository.getFriendsList();
    // isAccepted == true인 사용자만
    state = friends.where((friend) => friend.isAccepted!).toList();
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

  final String dummyName = '더미네임F';
  final String dummySex = '성별별~';

  void handleEmergencyAlert() async {
    final position = await GeolocatorService.getCurrentPosition();
    final lat = position.latitude;
    final lon = position.longitude;

    String message = '''
  [SOS] 긴급 상황입니다! 긴급 구조fmf 요청합니다.
  구조 요청자 정보:
  이름: $dummyName
  성별: $dummySex
  위치: 위도 $lat, 경도 $lon
  ''';

    List<String> recipents = ['119', '112'];

    try {
      String result = await sendSMS(
        message: message,
        recipients: recipents,
      ).catchError((onError) {
        debugPrint("SMS 전송 오류: $onError");
        return 'SMS 전송 오류';
      });

      debugPrint("SMS 전송: $result");
    } catch (e) {
      debugPrint("SMS 전송 실패: $e");
    }
  }
}

final rescueViewModelProvider =
    StateNotifierProvider<RescueViewModel, List<Friend>>((ref) {
  final friendsRepository = ref.read(friendsRepositoryProvider);
  return RescueViewModel(friendsRepository);
});
