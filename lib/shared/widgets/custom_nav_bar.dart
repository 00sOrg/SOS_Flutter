import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/navigation/app_routes.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIdx;
  final VoidCallback onHomePressed;
  final VoidCallback onOtherPressed;

  const CustomNavBar({
    super.key,
    required this.selectedIdx,
    required this.onHomePressed,
    required this.onOtherPressed,
  });

  void _onItemTap(BuildContext context, int idx) {
    if (idx == 0) {
      onHomePressed(); // 홈 버튼을 눌렀을 때 바텀시트를 열고 닫는 동작
    } else {
      onOtherPressed(); // 다른 버튼을 눌렀을 때 바텀시트를 닫는 동작
    }
    final route = AppRoutes.values[idx];
    context.go(route.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, -1),
            blurRadius: 6,
          )
        ],
      ),
      child: NavigationBar(
        selectedIndex: selectedIdx,
        // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Colors.white,
        height: 60,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (int idx) {
          _onItemTap(context, idx);
        },
        destinations: _navDestinations(selectedIdx),
      ),
    );
  }

  List<NavigationDestination> _navDestinations(int selectedIdx) {
    return [
      NavigationDestination(
        icon: Icon(
          Icons.location_on_outlined,
          color: selectedIdx == 0 ? Colors.black54 : Colors.black12,
          size: 32,
        ),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.post_add_outlined,
          color: selectedIdx == 1 ? Colors.black54 : Colors.black12,
          size: 32,
        ),
        label: 'Rescue',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.grid_view_outlined,
          color: selectedIdx == 2 ? Colors.black54 : Colors.black12,
          size: 32,
        ),
        label: 'Write',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.grid_view_outlined,
          color: selectedIdx == 3 ? Colors.black54 : Colors.black12,
          size: 32,
        ),
        label: 'Board',
      ),
      NavigationDestination(
        icon: Icon(
          Icons.grid_view_outlined,
          color: selectedIdx == 4 ? Colors.black54 : Colors.black12,
          size: 32,
        ),
        label: 'Profile',
      ),
    ];
  }
}
