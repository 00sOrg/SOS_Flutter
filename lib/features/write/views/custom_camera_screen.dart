import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/write/viewmodels/camera_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/utils/log_util.dart';

class CustomCameraScreen extends ConsumerStatefulWidget {
  const CustomCameraScreen({super.key});

  @override
  ConsumerState<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends ConsumerState<CustomCameraScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cameraViewModelProvider.notifier).initializeCamera();
    });
  }

  @override
  void dispose() {
    // _cameraController?.dispose();
    // ref.read(cameraViewModelProvider.notifier).disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraViewModelProvider);
    final viewModel = ref.read(cameraViewModelProvider.notifier);

    if (!cameraState.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blue,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CameraPreview(
                  cameraState.cameraController!,
                ),
              ],
            ), // 카메라 프리뷰
            Positioned(
              top: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 30, 24, 18),
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => GoRouter.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        color: AppColors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () => viewModel.skipTakingPicture(context),
                      child: const Text(
                        '건너뛰기',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                padding: const EdgeInsets.fromLTRB(30, 24, 30, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 32),
                    GestureDetector(
                      onTap: () async {
                        final image = await viewModel.captureImage();
                        if (image != null) {
                          GoRouter.of(context).push(
                            '/image-check',
                            extra: ImageCheckArguments(
                              imagePath: image.path,
                              viewOnly: false,
                            ),
                          );
                        } else {
                          LogUtil.e('Error: Image capture returned null');
                        }
                      },
                      child: Container(
                        width: 63.w,
                        height: 63.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.transparent,
                          border: Border.all(
                            color: AppColors.lightBlue,
                            width: 2.3,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 54.w,
                            height: 54.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.flipCamera();
                      },
                      child: const Icon(
                        Icons.autorenew,
                        color: AppColors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
