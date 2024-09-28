import 'dart:ui';

import 'package:flutter_naver_map/flutter_naver_map.dart';

class CustomMarker extends NMarker {
  final String id;
  final String? eventType;
  final NLatLng position;
  final Function onTap; // 마커 탭 시 실행할 콜백 함수 추가

  CustomMarker({
    required this.id,
    this.eventType,
    required this.position,
    required this.onTap, // 탭 콜백 전달받음
  }) : super(
          id: id,
          position: position,
          icon: NOverlayImage.fromAssetImage(_getMarkerIcon(eventType)),
          size: Size(60, 83),
        ) {
    // 마커 탭 리스너 설정
    setOnTapListener((NMarker marker) {
      onMarkerTap();
    });
  }

  static String _getMarkerIcon(String? eventType) {
    switch (eventType) {
      case 'FIRE':
        return 'assets/icons/home/Fire_marker.png';
      case 'TYPHOON':
        return 'assets/icons/home/Typhoon_marker.png';
      case 'FLOOD':
        return 'assets/icons/home/Flood_marker.png';
      case 'WAR':
        return 'assets/icons/home/War_marker.png';
      case 'CAR_ACCIDENT':
        return 'assets/icons/home/CarAccident_marker.png';
      case 'OTHER':
        return 'assets/icons/home/Others_marker.png';
      default:
        return 'assets/icons/home/Accident_marker.png';
    }
  }

  // 마커 탭 시 동작할 메소드
  void onMarkerTap() {
    onTap(); // 전달받은 콜백 함수 실행
  }
}

class CustomImageMarker extends NMarker {
  final String id;
  final String imageUrl;
  final String? eventType;
  final NLatLng position;
  final Function onTap; // 마커 탭 시 실행할 콜백 함수 추가

  CustomImageMarker({
    required this.id,
    required this.imageUrl,
    this.eventType,
    required this.position,
    required this.onTap, // 탭 콜백 전달받음
  }) : super(
          id: id,
          position: position,
          size: Size(110, 109),
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
