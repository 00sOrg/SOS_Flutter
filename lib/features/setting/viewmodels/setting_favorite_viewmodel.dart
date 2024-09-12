import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/setting/views/widgets/setting_modal.dart';
import 'package:sos/shared/enums/status_enum.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/styles/global_styles.dart';

class SettingFavoriteViewModel extends StateNotifier<List<Friend>> {
  SettingFavoriteViewModel() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final List<Friend> dummyFriends = [
      Friend(
        id: 1,
        name: '어마마마',
        address: '서울시 강남구',
        status: FriendStatus.friend,
      ),
      Friend(
        id: 2,
        name: '채리김',
        nickName: '세상에서 제일 좋아하는 내사랑',
        address: '경기도 수원시 영통구',
        profilePicture: 'https://picsum.photos/201',
        status: FriendStatus.friend,
      ),
      Friend(
        id: 3,
        name: '펜딩친구',
        nickName: '펜딩친구임',
        address: '경기도 수원시 영통구',
        profilePicture: 'https://picsum.photos/202',
        status: FriendStatus.pending,
      ),
    ];

    state = dummyFriends;
  }

  final Map<int, TextEditingController> _nicknameTECs = {};
  final Map<int, bool> _editModeStates = {};

  List<Friend> get favoriteFriends => state;

  TextEditingController getNicknameTEC(int friendId) {
    if (!_nicknameTECs.containsKey(friendId)) {
      _nicknameTECs[friendId] = TextEditingController(
        text:
            state.firstWhere((friend) => friend.id == friendId).nickName ?? '',
      );
      _nicknameTECs[friendId]!.addListener(() {
        state = [...state]; // trigger
      });
    }
    return _nicknameTECs[friendId]!;
  }

  bool isEditMode(int friendId) {
    return _editModeStates[friendId] ?? false;
  }

  void toggleEditMode(int friendId, bool isEditing) {
    _editModeStates[friendId] = isEditing;
    state = [...state]; // Trigger rebuild
  }

  void showDeleteModal({
    required BuildContext context,
    required int id,
    required String name,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext modalContext) {
        return SettingModal(
          title: name,
          content: '즐겨찾기에서 삭제하시겠습니까?',
          leftBtn: '취소',
          rightBtn: '삭제',
          rightBtnColor: AppColors.red,
          onRightBtnPressed: () {
            Navigator.of(modalContext).pop();
            deleteFavorite(id);
          },
        );
      },
    );
  }

  void deleteFavorite(int friendId) {
    state = state.where((friend) => friend.id != friendId).toList();
    _nicknameTECs.remove(friendId);
    _editModeStates.remove(friendId);
  }

  void saveFavorite(int friendId, String name) {
    final nickname = _nicknameTECs[friendId]?.text.trim();
    final updatedFriend = state
        .firstWhere((friend) => friend.id == friendId)
        .copyWith(
            nickName: (nickname == null || nickname.isEmpty) ? name : nickname);
    state = [
      for (final friend in state)
        if (friend.id == friendId) updatedFriend else friend,
    ];
    toggleEditMode(friendId, false);
  }

  void editFavorite(int friendId) {
    toggleEditMode(friendId, true);
  }

  void cancelEditFavorite(int friendId) {
    toggleEditMode(friendId, false);
  }

  void goToAddFavoritePage(BuildContext context) {
    GoRouter.of(context).push('/setting-favorite-search');
  }

  void searchFriend(BuildContext context, String text) {
    debugPrint('검색: $text');
    // 사실 search 결과 실패시 어케할지 처리 하는게 정석이지만,, 시간이 없으니 패스함
    // 무조건 올바른 검색 결과가 있다고 가정
    GoRouter.of(context).push('/setting-favorite-search-result');
  }

  void requestFavorite(BuildContext context, int id) {
    debugPrint('친친요청 리퀘 보냄 - id: $id');
    GoRouter.of(context).pop();
    GoRouter.of(context).pop();
  }

  Friend dummySearchResultFriend = Friend(
    id: 30,
    name: '이름임',
    nickName: '닉네임임',
    address: '주소 주소임',
    status: FriendStatus.stranger,
  );

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
