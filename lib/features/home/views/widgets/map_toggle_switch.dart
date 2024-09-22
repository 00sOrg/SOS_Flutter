import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';

class MapToggleSwitch extends ConsumerWidget {
  const MapToggleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    final isOn = !ref.watch(homeViewModelProvider).isSwitchLeft;

    return GestureDetector(
      onTap: () {
        homeViewModel.toggleSwitch();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        width: 46,
        height: 18,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC1C1C1),
              AppColors.white,
              AppColors.white,
            ],
            stops: [0.001, 0.7, 1.0],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 23,
                height: 13,
                decoration: BoxDecoration(
                  color: isOn ? AppColors.blue : AppColors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2), // Head shadow
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
