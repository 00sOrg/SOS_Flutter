import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/navigation/app_routes.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIdx;

  const CustomNavBar({super.key, required this.selectedIdx});

  void _onItemTap(BuildContext context, int idx) {
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
        label: 'Post',
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
