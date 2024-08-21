import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/setting/views/widgets/setting_modal.dart';

class SettingState {
  final bool isNotificationEnabled;

  SettingState({required this.isNotificationEnabled});

  SettingState copyWith({bool? isNotificationEnabled}) {
    return SettingState(
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
    );
  }
}

final settingViewModelProvider =
    StateNotifierProvider<SettingViewModel, SettingState>((ref) {
  return SettingViewModel();
});

class SettingViewModel extends StateNotifier<SettingState> {
  SettingViewModel() : super(SettingState(isNotificationEnabled: false));

  void toggleNotification(bool value) {
    state = state.copyWith(isNotificationEnabled: value);
    debugPrint('NOTI SWITCH ACTION');
  }

  void goToEditProfile(BuildContext context) {
    GoRouter.of(context).push('/setting-profile');
  }

  void goToHealthInfo(BuildContext context) {
    GoRouter.of(context).push('/setting-health');
  }

  void goToFavorites(BuildContext context) {
    GoRouter.of(context).push('/setting-favorite');
  }

  void showLogoutModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SettingModal(
          title: '로그아웃',
          content: '정말 로그아웃 하시겠습니까?',
          leftBtn: '취소',
          rightBtn: '로그아웃',
          onRightBtnPressed: () {
            _logout(context);
          },
        );
      },
    );
  }

  void showDeleteAccountModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SettingModal(
          title: '계정 삭제',
          content: '정말 계정을 삭제 하시겠습니까?\n다시 이용하려면 새로 가입해야 합니다.',
          leftBtn: '취소',
          rightBtn: '계정 삭제',
          onRightBtnPressed: () {
            _deleteAccount(context);
          },
        );
      },
    );
  }

  void _logout(BuildContext context) {
    // ref.read(authViewModelProvider).logout();
    debugPrint('TODO:: LOGOUT ACTION');
    Future.delayed(const Duration(milliseconds: 900), () {
      Navigator.of(context).pop();
    });
  }

  void _deleteAccount(BuildContext context) {
    debugPrint('TODO:: DELETE ACCOUNT ACTION');
    Future.delayed(const Duration(milliseconds: 900), () {
      Navigator.of(context).pop();
    });
  }
}
