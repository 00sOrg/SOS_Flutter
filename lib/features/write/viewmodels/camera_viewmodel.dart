import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/utils/log_util.dart';

class ImageCheckArguments {
  final String imagePath;
  final bool viewOnly;

  ImageCheckArguments({
    required this.imagePath,
    required this.viewOnly,
  });
}

class CameraState {
  final CameraController? cameraController;
  final bool isInitialized;

  CameraState({
    this.cameraController,
    this.isInitialized = false,
  });

  CameraState copyWith({
    CameraController? cameraController,
    bool? isInitialized,
  }) {
    return CameraState(
      cameraController: cameraController ?? this.cameraController,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

class CameraViewModel extends StateNotifier<CameraState> {
  CameraViewModel() : super(CameraState());

  List<CameraDescription> _cameras = [];

  Future<void> initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        final cameraController =
            CameraController(_cameras[0], ResolutionPreset.high);
        await cameraController.initialize();
        state = state.copyWith(
            cameraController: cameraController, isInitialized: true);
      }
    } catch (e) {
      LogUtil.e('Camera initialization error: $e');
    }
  }

  Future<XFile?> captureImage() async {
    if (state.cameraController != null && state.isInitialized) {
      try {
        final image = await state.cameraController?.takePicture();
        return image;
      } catch (e) {
        debugPrint('Capture error: $e');
      }
    }
    return null;
  }

  void skipTakingPicture(BuildContext context) {
    GoRouter.of(context).go('/write', extra: null);
  }

  void disposeCamera() {
    state.cameraController?.dispose();
    state = state.copyWith(cameraController: null, isInitialized: false);
  }

  @override
  void dispose() {
    disposeCamera();
    super.dispose();
  }
}

final cameraViewModelProvider =
    StateNotifierProvider<CameraViewModel, CameraState>(
  (ref) {
    return CameraViewModel();
  },
);
