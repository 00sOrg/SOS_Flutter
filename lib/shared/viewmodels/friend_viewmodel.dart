import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/providers/friend_repository_provider.dart';
import 'package:sos/shared/repositories/friends_repository.dart';
import 'package:sos/shared/repositories/user_repository.dart';
import 'package:sos/shared/utils/log_util.dart';

class FriendViewModel extends StateNotifier<List<Friend>> {
  final FriendsRepository friendsRepository;
  final UserRepository userRepository = UserRepository();

  // 생성자에서 friendsRepository를 초기화하고, 친구 목록을 불러옴.
  FriendViewModel(this.friendsRepository) : super([]) {
    fetchFriendList();
  }

  // 친구 목록을 불러와 상태를 업데이트함.
  Future<void> fetchFriendList() async {
    try {
      final friendsList = await friendsRepository.getFriendsList();

      // isAccepted가 true인 친구들만 필터링
      final acceptedFriends =
          friendsList.where((friend) => friend.isAccepted == true).toList();

      state = acceptedFriends;

      // 친구 목록을 불러온 뒤 위치 정보를 업데이트함.
      await fetchFriendsLocation();
    } catch (e) {
      state = [];
      LogUtil.e('Error fetching friend list: $e');
    }
  }

  Future<void> fetchFriendsLocation() async {
    try {
      final updatedFriendsList = await Future.wait(state.map((friend) async {
        try {
          final location =
              await userRepository.getUserById(friend.favoriteMemberId);

          // friend 객체를 복사하여 latitude와 longitude 값을 업데이트
          return friend.copyWith(
            latitude: location.latitude,
            longitude: location.longitude,
          );
        } catch (e) {
          LogUtil.e(
              'Error fetching location for friend ${friend.favoriteMemberId}: $e');
          return friend; // 오류가 발생한 경우 원래 친구 정보 유지
        }
      }).toList());

      // 위치가 업데이트된 친구 목록으로 상태를 갱신
      state = updatedFriendsList;
    } catch (e) {
      LogUtil.e('Error fetching friends locations: $e');
    }
  }

  // 친구
}

// FriendViewModel을 관리하는 StateNotifierProvider 정의
final friendViewModelProvider =
    StateNotifierProvider<FriendViewModel, List<Friend>>((ref) {
  final friendsRepository = ref.watch(friendsRepositoryProvider);
  return FriendViewModel(friendsRepository);
});
