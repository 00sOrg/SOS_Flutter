import 'package:flutter/material.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';

class ImageSection extends StatelessWidget {
  final PostViewModel viewModel;

  const ImageSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return viewModel.hasImage
        ? Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(viewModel.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
