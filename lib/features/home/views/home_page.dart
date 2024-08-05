import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/features/home/views/widgets/header_btn.dart';
import 'package:sos/features/home/views/widgets/favorites_dropdown.dart';
import 'package:sos/features/home/views/widgets/home_search_bar.dart';
import 'package:sos/features/home/views/widgets/map_area.dart';
import 'package:sos/features/home/views/widgets/map_toggle_switch.dart';
import 'package:sos/shared/providers/location_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsyncValue = ref.watch(locationProvider);
    final isFavoritesOpen = ref
        .watch(homeViewModelProvider.select((state) => state.isFavoritesOpen));
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          locationAsyncValue.when(
            data: (location) {
              return Stack(
                children: [
                  MapWidget(location: location),
                  _homeTopArea(context, ref),
                  if (isFavoritesOpen)
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
          )
        ],
      ),
    );
  }

  Positioned _homeTopArea(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 70,
      left: 20,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderBtn(
                  onTap: () =>
                      ref.read(homeViewModelProvider.notifier).toggleDropdown(),
                  icon: const Icon(Icons.people),
                ),
                HomeSearchBar(),
                HeaderBtn(
                  onTap: () => ref
                      .read(homeViewModelProvider.notifier)
                      .navigateToNotificationPage(context),
                  icon: const Icon(Icons.notifications),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          MapToggleSwitch(),
        ],
      ),
    );
  }
}
