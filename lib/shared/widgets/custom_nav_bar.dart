import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIdx;

  const CustomNavBar({super.key, required this.selectedIdx});

  void _onItemTap(BuildContext context, int idx) {
    switch (idx) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/write');
        break;
      case 2:
        context.go('/board');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, -1),
            blurRadius: 6)
      ]),
      child: NavigationBar(
        selectedIndex: selectedIdx,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Colors.white,
        height: 60,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (int idx) {
          _onItemTap(context, idx);
        },
        destinations: <NavigationDestination>[
          NavigationDestination(
              icon: Icon(
                Icons.location_on_outlined,
                color: selectedIdx == 0 ? Colors.black54 : Colors.black12,
                size: 32,
              ),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(
                Icons.post_add_outlined,
                color: selectedIdx == 1 ? Colors.black54 : Colors.black12,
                size: 32,
              ),
              label: 'Post'),
          NavigationDestination(
              icon: Icon(
                Icons.grid_view_outlined,
                color: selectedIdx == 2 ? Colors.black54 : Colors.black12,
                size: 32,
              ),
              label: 'Board'),
        ],
      ),
    );
  }
}
