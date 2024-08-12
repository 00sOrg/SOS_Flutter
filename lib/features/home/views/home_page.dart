import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/shared/providers/location_provider.dart';
import 'package:sos/features/home/views/widgets/header_btn.dart';
import 'package:sos/features/home/views/widgets/favorites_dropdown.dart';
import 'package:sos/features/home/views/widgets/home_search_bar.dart';
import 'package:sos/features/home/views/widgets/map_area.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showNonModalBottomSheet(context, ref); // 분리된 함수 호출
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationAsyncValue = ref.watch(locationProvider);
    final isDropDownOpen = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: Stack(
        children: [
          locationAsyncValue.when(
            data: (location) {
              return Stack(
                children: [
                  MapWidget(location: location),
                  _homeTopArea(context, ref),
                  if (isDropDownOpen)
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
        ],
      ),
    );
  }

  Positioned _homeTopArea(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 70,
      left: 20,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 이건 여차하면 Favorites랑 Notification 버튼을 한 위젯으로 합칠 수 있을 것 같아서 일단 onTap을 파라미터로 받도록 구현해둔거임
            // 이런 경우 아니라면 그냥 각 위젯 안에 onTap 넣는게 깔끔쓰
            HeaderBtn(
              onTap: () =>
                  ref.read(homeViewModelProvider.notifier).toggleDropdown(),
              icon: const Icon(Icons.notifications),
            ),
            HomeSearchBar(),
            HeaderBtn(
              onTap: () => ref
                  .read(homeViewModelProvider.notifier)
                  .navigateToNotificationPage(context),
              icon: const Icon(Icons.people),
            ),
          ],
        ),
      ),
    );
  }
}
