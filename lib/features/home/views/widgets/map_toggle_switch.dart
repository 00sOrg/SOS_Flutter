import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/features/home/viewmodels/mapController_viewmodel.dart';
import 'package:sos/features/home/viewmodels/map_viewmodel.dart';
import 'package:sos/shared/widgets/custom_switch.dart';

class MapToggleSwitch extends ConsumerWidget {
  const MapToggleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    final isOn = !ref.watch(homeViewModelProvider).isSwitchLeft;
    final mapViewModel = ref.read(mapViewModelProvider.notifier);
    final mapController = ref.watch(mapControllerProvider);

    return CustomSwitch(
      isOn: isOn,
      onTap: () async {
        // mapController가 null이 아닌지 확인하고 처리
        if (mapController != null) {
          homeViewModel.toggleSwitch();
          await mapViewModel.onToggleSwitchTapped(mapController);
        } else {
          // 만약 controller가 아직 초기화되지 않았다면, 로그를 남기거나 예외 처리를 할 수 있음
          debugPrint('MapController가 아직 초기화되지 않았습니다.');
        }
      },
    );
  }
}
