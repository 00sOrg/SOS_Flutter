import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/features/home/views/widgets/header_btn.dart';
import 'package:sos/features/home/views/widgets/favorites_dropdown.dart';
import 'package:sos/features/home/views/widgets/home_search_bar.dart';
import 'package:sos/features/home/views/widgets/map_area.dart';
import 'package:sos/shared/providers/location_provider.dart';
import 'package:sos/features/home/views/bottom_sheet_content.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/shared/utils/log_util.dart'; // LogUtil 임포트

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final DraggableScrollableController _scrollableController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showNonModalBottomSheet(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationAsyncValue = ref.watch(locationProvider);
    final isDropDownOpen = ref.watch(homeViewModelProvider);
    final sheetPercentage = ref.watch(bottomSheetViewModelProvider);

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
              child: Text(
                'Error: $error',
              ),
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

// TODO: 드래그 하면 올라가고, 내려가게  & 홈 버튼 누르면 다시 올라오게
  void _showNonModalBottomSheet(BuildContext context, WidgetRef ref) {
    final sheetPercentage = ref.read(bottomSheetViewModelProvider);

    showBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          controller: _scrollableController,
          initialChildSize: sheetPercentage,
          minChildSize: 0.0, // 최소 크기 0%
          maxChildSize: 0.8, // 최대 크기 80%
          expand: false,
          builder: (context, scrollController) {
            double previousExtent = sheetPercentage;

            return NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                final extent = notification.extent;
                final sheetNotifier =
                    ref.read(bottomSheetViewModelProvider.notifier);

                // 로그 추가
                LogUtil.d('Current extent: $extent');

                if (extent > previousExtent && previousExtent >= 0.2) {
                  sheetNotifier.setSheetPercentage(0.8);
                } else if (extent <= 0.2 && previousExtent > 0.2) {
                  // extent가 0.2 이하로 내려가면 시트를 닫음
                  Navigator.of(context).pop(); // 바텀시트 닫기
                }

                previousExtent = extent;
                return true;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: BottomSheetContent(scrollController: scrollController),
              ),
            );
          },
        );
      },
    ).closed.then((_) {
      LogUtil.e("Bottom sheet closed");
      ref.read(bottomSheetViewModelProvider.notifier).setSheetPercentage(0.2);
    });
  }
}
