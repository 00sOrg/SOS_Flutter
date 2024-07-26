import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/views/widgets/map_area.dart';
import 'package:sos/shared/providers/location_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsyncValue = ref.watch(locationProvider);

    return Scaffold(
      body: Stack(
        children: [
          locationAsyncValue.when(
            data: (location) {
              return MapArea(location: location);
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
}
