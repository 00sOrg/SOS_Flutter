import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/providers/friend_repository_provider.dart';
import 'package:sos/shared/repositories/friends_repository.dart';

class RescueViewModel extends StateNotifier<List<Friend>> {
  final FriendsRepository friendsRepository;

  RescueViewModel(this.friendsRepository) : super([]) {
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    final friends = await friendsRepository.getFriendsList();
    // isAccepted == true인 사용자만
    state = friends.where((friend) => friend.isAccepted).toList();
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
    StateNotifierProvider<RescueViewModel, List<Friend>>((ref) {
  final friendsRepository = ref.read(friendsRepositoryProvider);
  return RescueViewModel(friendsRepository);
});
