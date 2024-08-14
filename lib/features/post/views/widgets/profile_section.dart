import 'package:flutter/material.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';

class ProfileSection extends StatelessWidget {
  final PostViewModel viewModel;

  const ProfileSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.0,
          backgroundImage: NetworkImage(viewModel.profileImageUrl),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${viewModel.date} · ${viewModel.location}',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
