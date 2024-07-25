import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearhere/features/home/widgets/header_area.dart';
import 'package:nearhere/features/home/widgets/map_area.dart';
import 'package:nearhere/features/home/widgets/target_button.dart';
import 'package:nearhere/shared/viewmodels/location_viewmodel.dart';
import 'package:nearhere/shared/widgets/gradient_container.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsyncValue = ref.watch(locationProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            locationAsyncValue.when(
              data: (location) {
                return Column(
                  children: <Widget>[
                    GradientContainer(
                      child: HeaderArea(location: location),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: MapArea(location: location),
                    ),
                  ],
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
            const Positioned(
              right: 20,
              bottom: 20,
              child: TargetButton(),
            ),
          ],
        ),
      ),
    );
  }
}
