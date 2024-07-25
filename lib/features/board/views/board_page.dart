import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearhere/features/board/viewmodels/board_viewmodel.dart';
import 'package:nearhere/features/board/widgets/post_grid_area.dart';
import 'package:nearhere/shared/models/location.dart';
import 'package:nearhere/shared/viewmodels/location_viewmodel.dart';
import 'package:nearhere/shared/widgets/custom_app_bar.dart';
import 'package:nearhere/shared/widgets/refresh_button.dart';

class BoardPage extends ConsumerWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(boardViewModelProvider);
    final location = ref.watch(locationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: '게시판', hasLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          children: [
            location.when(
              data: (location) => boardTopArea(location),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
            const SizedBox(height: 18),
            posts.when(
              data: (posts) => PostGridArea(posts: posts),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ],
        ),
      ),
    );
  }

  Widget boardTopArea(Location location) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const RefreshButton(),
        const SizedBox(width: 14),
        Text(
          location.adminAddress,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF595959),
          ),
        ),
      ],
    );
  }
}
