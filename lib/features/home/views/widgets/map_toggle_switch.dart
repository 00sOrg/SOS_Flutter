import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/shared/widgets/custom_switch.dart';

class MapToggleSwitch extends ConsumerWidget {
  const MapToggleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    final isOn = !ref.watch(homeViewModelProvider).isSwitchLeft;

    return CustomSwitch(
      isOn: isOn,
      onTap: () => homeViewModel.toggleSwitch(),
    );
  }
}
