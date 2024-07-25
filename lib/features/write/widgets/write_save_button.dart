import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nearhere/features/board/viewmodels/board_viewmodel.dart';
import 'package:nearhere/features/write/viewmodels/write_viewmodel.dart';
import 'package:nearhere/shared/models/location.dart';
import 'package:nearhere/shared/services/location_service.dart';

final tempLocationProvider = FutureProvider<Location>((ref) async {
  final locationService = LocationService();
  return await locationService.getCurrentLocation();
});

class WriteSaveButton extends ConsumerWidget {
  final WriteViewModel viewModel;

  const WriteSaveButton({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        try {
          final locationData = await ref.refresh(tempLocationProvider.future);

          await viewModel.createPost(locationData.roadAddress);

          ref.invalidate(boardViewModelProvider);
          context.go('/board');
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch location: $error')),
          );
        }
      },
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Text(
          '저장',
          style: TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
