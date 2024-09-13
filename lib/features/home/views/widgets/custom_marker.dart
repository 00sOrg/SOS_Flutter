import 'package:flutter_naver_map/flutter_naver_map.dart';

class CustomMarker extends NMarker {
  final String id;
  final NLatLng position;
  final NOverlayCaption caption;
  final Function onTap; // 마커 탭 시 실행할 콜백 함수 추가

  CustomMarker({
    required this.id,
    required this.position,
    required this.caption,
    required this.onTap, // 탭 콜백 전달받음
  }) : super(
          id: id,
          position: position,
          caption: caption,
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
