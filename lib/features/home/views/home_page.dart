import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/shared/viewmodels/user_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet.dart';
import 'package:sos/features/home/views/widgets/header_btn.dart';
import 'package:sos/features/home/views/widgets/favorites_dropdown.dart';
import 'package:sos/features/home/views/widgets/home_search_bar.dart';
import 'package:sos/features/home/views/widgets/map_area.dart';
import 'package:sos/features/home/views/widgets/map_toggle_switch.dart';
import 'package:sos/features/home/views/side_sheet/alarm_side_sheet.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/shared/viewmodels/location_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userViewModelProvider.notifier).loadUserInfo();
    });
    ref.read(bottomSheetViewModelProvider.notifier).initState();
    ref.read(userViewModelProvider.notifier).updateUserLocation();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('HomePageState dispose');
  }

  @override
  Widget build(BuildContext context) {
    final locationAsyncValue = ref.watch(locationViewModelProvider);
    final isFavoritesOpen = ref
        .watch(homeViewModelProvider.select((state) => state.isFavoritesOpen));
    final isSideSheetOpen = ref.watch(homeViewModelProvider
        .select((state) => state.isNotificationSideSheetOpen));
    final isSwitchLeft =
        ref.watch(homeViewModelProvider.select((state) => state.isSwitchLeft));

    debugPrint('isSwitchLeft: $isSwitchLeft');
    return KeyboardDismisser(
      child: Scaffold(
        body: Stack(
          children: [
            locationAsyncValue.when(
              data: (location) {
                return Stack(
                  children: [
                    // MapWidget에 위치와 Post 리스트를 전달합니다.
                    MapWidget(
                      currentLocation: location,
                      level: isSwitchLeft
                          ? 'all'
                          : 'primary', // Handle the switch here
                    ),
                    _homeTopArea(context, ref),
                    if (isFavoritesOpen)
                      const Positioned(
                        top: 70 + 42 + 7,
                        left: 20,
                        child: FavoritesDropdown(),
                      ),
                  ],
                );
              },
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            if (isSideSheetOpen) const AlarmSideSheet(),
          ],
        ),
        bottomSheet: HomePageBottomSheet(),
      ),
    );
  }

  Positioned _homeTopArea(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 70,
      left: 15, // 좌우 패딩 설정
      right: 15,
      child: Column(
        children: [
          SizedBox(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderBtn(
                  onTap: () =>
                      ref.read(homeViewModelProvider.notifier).toggleDropdown(),
                  icon: Image.asset(
                    'assets/icons/home/favorites.png',
                    width: 36,
                    height: 36,
                  ),
                ),
                const SizedBox(width: 15),
                // HomeSearchBar(toggleOverlay: _toggleOverlay),
                const HomeSearchBar(),
                const SizedBox(width: 15),
                HeaderBtn(
                  onTap: () => showAlarmSideSheet(context, ref),
                  icon: Align(
                    alignment: Alignment(0, 0.5), // 세로로 조금 아래로 이동
                    child: Image.asset(
                      'assets/icons/home/notifications.png',
                      width: 36,
                      height: 36,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const MapToggleSwitch(),
        ],
      ),
    );
  }
}
