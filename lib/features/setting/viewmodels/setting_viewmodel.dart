import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
}
