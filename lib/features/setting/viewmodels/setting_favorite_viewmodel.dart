import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/friend.dart';

class SettingFavoriteViewModel extends StateNotifier<List<Friend>> {
  SettingFavoriteViewModel() : super([]) {
    _loadFavorites();
  }

  final Map<int, TextEditingController> _nicknameTECs = {};
  final Map<int, bool> _editModeStates = {};

  List<Friend> get favoriteFriends => state;

  TextEditingController getNicknameTEC(int friendId) {
    return _nicknameTECs[friendId] ??= TextEditingController(
      text: state.firstWhere((friend) => friend.id == friendId).nickName ?? '',
    );
  }

  bool isEditMode(int friendId) {
    return _editModeStates[friendId] ?? false;
  }

  void toggleEditMode(int friendId, bool isEditing) {
    _editModeStates[friendId] = isEditing;
    state = [...state]; // Trigger rebuild
  }

  void deleteFavorite(int friendId) {
    state = state.where((friend) => friend.id != friendId).toList();
    _nicknameTECs.remove(friendId);
    _editModeStates.remove(friendId);
  }

  void saveFavorite(int friendId) {
    final nickname = _nicknameTECs[friendId]?.text.trim();
    final updatedFriend = state.firstWhere((friend) => friend.id == friendId)
        .copyWith(nickName: nickname);
    state = [
      for (final friend in state)
        if (friend.id == friendId) updatedFriend else friend,
    ];
    toggleEditMode(friendId, false);
  }

  void editFavorite(int friendId) {
    toggleEditMode(friendId, true);
  }

  Future<void> _loadFavorites() async {
    final List<Friend> dummyFriends = [
      Friend(
        id: 1,
        name: '어마마마',
        address: '서울시 강남구',
      ),
      Friend(
        id: 2,
        name: '채리김',
        nickName: '세상에서 제일 좋아하는 내사랑 우하하',
        address: '경기도 수원시 영통구',
        profilePicture: 'https://picsum.photos/201',
      ),
    ];

    state = dummyFriends;
  }

  @override
  void dispose() {
    for (final controller in _nicknameTECs.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

final settingFavoriteViewModelProvider =
    StateNotifierProvider<SettingFavoriteViewModel, List<Friend>>(
  (ref) => SettingFavoriteViewModel(),
);