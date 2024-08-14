import 'package:flutter/material.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';

class ContentSection extends StatelessWidget {
  final PostViewModel viewModel;

  const ContentSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Text(
      viewModel.content,
      style: const TextStyle(fontSize: 16.0),
    );
  }
}
