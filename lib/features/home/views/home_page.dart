import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/viewmodels/user_viewmodel.dart';
import 'package:sos/features/home/views/widgets/header_btn.dart';
import 'package:sos/features/home/views/widgets/favorites_dropdown.dart';
import 'package:sos/features/home/views/widgets/home_search_bar.dart';
import 'package:sos/features/home/views/widgets/map_area.dart';
import 'package:sos/features/home/views/widgets/map_toggle_switch.dart';
import 'package:sos/features/home/views/side_sheet/notification_side_sheet.dart';
import 'package:sos/shared/providers/location_provider.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    // 페이지가 로드될 때 사용자 정보를 불러옵니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userViewModelProvider.notifier).loadUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationAsyncValue = ref.watch(locationProvider);
    final isFavoritesOpen = ref
        .watch(homeViewModelProvider.select((state) => state.isFavoritesOpen));
    final isSideSheetOpen = ref.watch(homeViewModelProvider
        .select((state) => state.isNotificationSideSheetOpen));

    return Scaffold(
      body: Stack(
        children: [
          locationAsyncValue.when(
            data: (location) {
              return Stack(
                children: [
                  MapWidget(location: location),
                  _homeTopArea(context, ref),
                  if (isFavoritesOpen)
                    Positioned(
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
          if (isSideSheetOpen) const NotificationSideSheet(),
        ],
      ),
      bottomSheet: HomePageBottomSheet(), // 여기에 바텀시트를 추가하여 항상 하단에 위치하게 합니다.
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
                  icon: const Icon(Icons.people),
                ),
                const SizedBox(width: 15),
                HomeSearchBar(),
                const SizedBox(width: 15),
                HeaderBtn(
                  onTap: () => showNotificationSideSheet(context, ref),
                  icon: const Icon(Icons.notifications),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          MapToggleSwitch(),
        ],
      ),
    );
  }
}
