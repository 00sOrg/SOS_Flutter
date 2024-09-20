import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/navigation/app_routes.dart';
import 'package:sos/shared/styles/global_styles.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIdx;
  final VoidCallback onHomePressed;

  const CustomNavBar({
    super.key,
    required this.selectedIdx,
    required this.onHomePressed,
  });

  void _onItemTap(BuildContext context, int idx) {
    if (idx == 0) {
      onHomePressed(); // 홈 버튼을 눌렀을 때 바텀시트를 열고 닫는 동작
    }
    final route = AppRoutes.values[idx];
    GoRouter.of(context).go(route.path);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.blue,
              fontSize: 12,
            );
          }
          return const TextStyle(
            //color: Color(0xFFC1C1C1),
            color: AppColors.textGray,
            fontSize: 12,
          );
        }),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, -1),
                  blurRadius: 5,
                )
              ],
            ),
            child: NavigationBar(
              // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: selectedIdx,
              backgroundColor: Colors.white,
              height: 70,
              indicatorColor: Colors.transparent,
              onDestinationSelected: (int idx) {
                _onItemTap(context, idx);
              },
              destinations: _navDestinations(selectedIdx),
            ),
          ),
          Positioned(
            // bottom: 70,
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                _onItemTap(context, 2);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.blue,
                    width: 4,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 30, // Larger icon size
                    color: AppColors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<NavigationDestination> _navDestinations(int selectedIdx) {
    double size = 36;
    return [
      NavigationDestination(
        icon: Icon(
          // Icons.home,
          Icons.location_on_outlined,
          color: selectedIdx == 0 ? AppColors.blue : AppColors.textGray,
          size: size,
        ),
        label: '홈화면',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.sos,
          color: selectedIdx == 1 ? AppColors.blue : AppColors.textGray,
          size: size,
        ),
        label: '구조요청',
      ),
      const NavigationDestination(
        enabled: false,
        icon: SizedBox(width: 36, height: 36),
        // label: '사건/사고 추가',
        label: '',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.star,
          color: selectedIdx == 3 ? AppColors.blue : AppColors.textGray,
          size: size,
        ),
        label: '사건/사고 목록',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.menu,
          color: selectedIdx == 4 ? AppColors.blue : AppColors.textGray,
          size: size,
        ),
        label: '내 정보',
      ),
    ];
  }
}
