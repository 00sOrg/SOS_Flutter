import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos/shared/styles/global_styles.dart';

class ImageCheckPage extends StatelessWidget {
  final String imagePath;
  final bool viewOnly;

  const ImageCheckPage({
    required this.imagePath,
    required this.viewOnly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final XFile image = XFile(imagePath);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          viewOnly
              ? Positioned(
                  left: 20,
                  top: 30,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.black.withOpacity(0.4),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          viewOnly
              ? const SizedBox.shrink()
              : Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.4),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _btn(
                          text: '재촬영',
                          onTap: () => GoRouter.of(context).pop(),
                        ),
                        const SizedBox(width: 22),
                        _btn(
                          text: '확인',
                          onTap: () => GoRouter.of(context).go(
                            '/write',
                            extra: image,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _btn({required String text, required VoidCallback onTap}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          overlayColor: AppColors.black.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class NoImageCheckPage extends StatelessWidget {
  const NoImageCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.black,
      body: Center(child: Text('No image')),
    );
  }
}
