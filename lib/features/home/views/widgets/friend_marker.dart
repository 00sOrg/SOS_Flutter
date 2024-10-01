import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class FriendMarker extends NMarker {
  final String id;
  final NOverlayImage nOverlayImage;
  final String nickname;
  final NLatLng position;
  final Function onTap; // 마커 탭 시 실행할 콜백 함수 추가 (일단은 처리하지 않음)

  FriendMarker({
    required this.id,
    required this.nOverlayImage,
    required this.nickname,
    required this.position,
    required this.onTap,
  }) : super(
          id: 'friend' + id,
          position: position,
          icon: nOverlayImage,
          caption: NOverlayCaption(text: '$nickname'),
          size: const Size(64, 64),
        ) {
    // 마커 탭 리스너 설정
    setOnTapListener((NMarker marker) {
      onMarkerTap();
    });
  }

  // 마커 탭 시 동작할 메소드
  void onMarkerTap() {
    onTap(); // 전달받은 콜백 함수 실행
  }
}

Future<NOverlayImage> buildFriendImageMarkerWidget(
  String imageUrl,
  BuildContext context,
) async {
  final completer = Completer<ImageInfo>();
  final image = NetworkImage(imageUrl);
  image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool syncCall) {
          completer.complete(info);
        }, onError: (dynamic error, StackTrace? stackTrace) {
          completer.completeError(error, stackTrace);
        }),
      );

  try {
    // 이미지 로드 완료 대기
    await completer.future;
  } catch (error) {
    debugPrint('Error loading image: $error');
    // 로드 실패 시 기본 오류 아이콘을 반환
    return NOverlayImage.fromWidget(
      widget: const Icon(Icons.error, size: 50),
      size: const Size(64, 64),
      context: context,
    );
  }

  // 이미지가 로드되면 NOverlayImage 생성
  final nOverlayImage = await NOverlayImage.fromWidget(
    widget: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/icons/home/marker/Friend_marker.png',
          width: 62,
          height: 62,
        ),
        Positioned(
          top: 11,
          child: ClipOval(
            child: Image.network(
              imageUrl,
              width: 42,
              height: 42,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 48);
              },
            ),
          ),
        ),
      ],
    ),
    size: const Size(64, 64),
    context: context,
  );

  return nOverlayImage;
}

Future<NOverlayImage> buildFriendMarkerWidget(
  String? imageUrl,
  BuildContext context,
) async {
  // 프로필 이미지가 없는 경우 기본 이미지를 사용
  final defaultImage = Image.asset(
    'assets/images/default_profile.png',
    width: 36,
    height: 36,
  );

  // 이미지 로드를 위한 Widget 생성
  final nOverlayImage = await NOverlayImage.fromWidget(
    widget: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/icons/home/marker/Friend_marker.png',
          width: 64,
          height: 64,
        ),
        Positioned(
          top: 14,
          child: ClipOval(
            child: defaultImage,
          ),
        ),
      ],
    ),
    size: const Size(64, 64),
    context: context,
  );

  return nOverlayImage;
}
