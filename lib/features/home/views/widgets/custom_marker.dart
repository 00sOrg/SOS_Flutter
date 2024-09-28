import 'dart:ui';

import 'package:flutter/material.dart';
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
          size: Size(53.62, 73.99),
        ) {
    // 마커 탭 리스너 설정
    setOnTapListener((NMarker marker) {
      onMarkerTap();
    });
  }

  static String _getMarkerIcon(String? eventType) {
    switch (eventType) {
      case 'FIRE':
        return 'assets/icons/home/marker/Fire_marker.png';
      case 'TYPHOON':
        return 'assets/icons/home/marker/Typhoon_marker.png';
      case 'FLOOD':
        return 'assets/icons/home/marker/Flood_marker.png';
      case 'WAR':
        return 'assets/icons/home/marker/War_marker.png';
      case 'CAR_ACCIDENT':
        return 'assets/icons/home/marker/CarAccident_marker.png';
      case 'OTHER':
        return 'assets/icons/home/marker/Others_marker.png';
      default:
        return 'assets/icons/home/marker/Accident_marker.png';
    }
  }

  // 마커 탭 시 동작할 메소드
  void onMarkerTap() {
    onTap(); // 전달받은 콜백 함수 실행
  }
}

class CustomImageMarker extends NMarker {
  final String id;
  final NOverlayImage nOverlayImage;
  final NLatLng position;
  final Function onTap;

  CustomImageMarker({
    required this.id,
    required this.nOverlayImage,
    required this.position,
    required this.onTap,
  }) : super(
          id: id,
          position: position,
          icon: nOverlayImage,
          size: const Size(63.62, 69),
        ) {
    setOnTapListener((NMarker marker) {
      onMarkerTap();
    });
  }

  void onMarkerTap() {
    onTap();
  }
}

Future<NOverlayImage> buildImageMarkerWidget(
    String imageUrl, String eventType, BuildContext context) async {
  final nOverlayImage = await NOverlayImage.fromWidget(
    widget: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          getImageMarkerIcon(eventType), // Custom marker background asset
          width: 86,
          height: 94,
        ),
        Positioned(
          top: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3.0),
            child: Image.network(
              imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 72);
              },
              // loadingBuilder: (context, child, loadingProgress) {
              //   if (loadingProgress == null) return child;
              //   return const CircularProgressIndicator();
              // },
            ),
          ),
        ),
      ],
    ),
    size: const Size(85.34, 93), // Size of the widget
    context: context,
  );
  debugPrint(nOverlayImage.toString());
  return nOverlayImage;
}

String getImageMarkerIcon(String? eventType) {
  switch (eventType) {
    case 'FIRE':
      return 'assets/icons/home/marker/Fire_image_marker.png';
    case 'TYPHOON':
      return 'assets/icons/home/marker/Typhoon_image_marker.png';
    case 'FLOOD':
      return 'assets/icons/home/marker/Flood_image_marker.png';
    case 'WAR':
      return 'assets/icons/home/marker/War_image_marker.png';
    case 'OTHER':
      return 'assets/icons/home/marker/Others_image_marker.png';
    case 'CAR_ACCIDENT':
      return 'assets/icons/home/marker/CarAccident_imgae_marker.png';
    default:
      return 'assets/icons/home/marker/Accident_image_marker.png';
  }
}
