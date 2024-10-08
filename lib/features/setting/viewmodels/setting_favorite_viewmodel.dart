import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/setting/views/widgets/setting_modal.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/providers/friend_repository_provider.dart';
import 'package:sos/shared/providers/user_repository_provider.dart';
import 'package:sos/shared/repositories/friends_repository.dart';
import 'package:sos/shared/repositories/user_repository.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/utils/log_util.dart';

class SettingFavoriteViewModel extends StateNotifier<List<Friend>> {
  final FriendsRepository friendsRepository;
  final UserRepository userRepository;

  Friend? _searchedUser;
  Friend? get searchedUser => _searchedUser;

  SettingFavoriteViewModel(this.friendsRepository, this.userRepository)
      : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final friends = await friendsRepository.getFriendsList();
      state = friends; // Update the state with the fetched friends
    } catch (e) {
      debugPrint('Error fetching friends: $e');
    }
  }

  final Map<int, TextEditingController> _nicknameTECs = {};
  final Map<int, bool> _editModeStates = {};

  List<Friend> get favoriteFriends => state;

  TextEditingController getNicknameTEC(int friendId) {
    if (!_nicknameTECs.containsKey(friendId)) {
      _nicknameTECs[friendId] = TextEditingController(
        text: state
            .firstWhere((friend) => friend.favoriteMemberId == friendId)
            .modifiedNickname,
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

  Future<void> deleteFavorite(int friendId) async {
    final success = await friendsRepository.deleteFriend(friendId);

    if (success) {
      state =
          state.where((friend) => friend.favoriteMemberId != friendId).toList();
      _nicknameTECs.remove(friendId);
      _editModeStates.remove(friendId);
    } else {
      LogUtil.e('deleteFavorite 실패 - id: $friendId');
    }
  }

  Future<void> saveFavorite(
      int friendId, String modifiedName, String nickName) async {
    String nickname;
    if (_nicknameTECs[friendId]?.text.trim() == null ||
        _nicknameTECs[friendId]?.text.trim().isEmpty == true) {
      nickname = nickName;
    } else {
      nickname = _nicknameTECs[friendId]!.text.trim();
    }
    await friendsRepository.patchFriendNickname(friendId, nickname);
    final updatedFriend = state
        .firstWhere((friend) => friend.favoriteMemberId == friendId)
        .copyWith(
            modifiedNickname: (nickname == null || nickname.isEmpty)
                ? modifiedName
                : nickname);
    state = [
      for (final friend in state)
        if (friend.favoriteMemberId == friendId) updatedFriend else friend,
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

  Future<void> searchFriend(BuildContext context, String text) async {
    debugPrint('검색: $text');
    final user = await userRepository.getUserByNickname(text);

    // 검색했는데 사용자가 없는 경우
    if (user.memberId == -1) {
      debugPrint('검색 결과 없음');
      _searchedUser = Friend(
        favoriteMemberId: -1,
        nickname: 'Unknown',
        modifiedNickname: 'Unknown',
      );
    } else {
      _searchedUser = Friend(
        favoriteMemberId: user.memberId!,
        nickname: user.nickname!,
        modifiedNickname: user.nickname!,
        profilePicture: user.profilePicture,
        isAccepted: true, //true로 임의로 처리중 (SettingNotFavoriteBlock을 사용하고 있기 때문)
      );
    }
    debugPrint(_searchedUser.toString());
    state = [...state];
    GoRouter.of(context).push('/setting-favorite-search-result');
  }

  void requestFavorite(BuildContext context, String nickname) {
    debugPrint('친친요청 리퀘 보냄 - nickname: $nickname');
    friendsRepository.addFriend(context, nickname);
    GoRouter.of(context).pop();
    GoRouter.of(context).pop();
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
  (ref) {
    final friendsRepository = ref.read(friendsRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);
    return SettingFavoriteViewModel(friendsRepository, userRepository);
  },
);
