import 'dart:ui';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class FriendMarker extends NMarker {
  final String id;
  final String nickname;
  final NLatLng position;
  final Function onTap; // 마커 탭 시 실행할 콜백 함수 추가 (일단은 처리하지 않음)

  FriendMarker({
    required this.id,
    required this.nickname,
    required this.position,
    required this.onTap,
  }) : super(
          id: 'friend' + id,
          position: position,
          icon: NOverlayImage.fromAssetImage(
              'assets/icons/home/marker/Friend_marker.png'),
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
