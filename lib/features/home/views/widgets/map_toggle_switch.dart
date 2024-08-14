import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';

class MapToggleSwitch extends ConsumerWidget {
  const MapToggleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSwitchLeft =
        ref.watch(homeViewModelProvider.select((state) => state.isSwitchLeft));
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    return CupertinoSwitch(
      value: !isSwitchLeft,
      onChanged: (value) {
        homeViewModel.toggleSwitch();
      },
    );
  }
}
