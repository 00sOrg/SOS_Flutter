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
          size: const Size(53.62, 73.99),
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
  String imageUrl,
  String eventType,
  BuildContext context,
) async {
  final Color widgetColor = _getImageMarkerColor(eventType);
  final nOverlayImage = await NOverlayImage.fromWidget(
    widget: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(3.5),
            decoration: BoxDecoration(
              color: widgetColor,
              borderRadius:
                  BorderRadius.circular(6.5), // 내부 radius + 패딩값으로 계산해야 예쁘게 나옴
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 48);
                },
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          // 삼각형 핀
          child: CustomPaint(
            size: const Size(16, 13),
            painter: _TrianglePainter(widgetColor),
          ),
        ),
      ],
    ),
    size: const Size(70, 70 + 10), // 원래 13이어야하지만..
    context: context,
    // Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Image.asset(
    //       getImageMarkerIcon(eventType), // Custom marker background asset
    //       width: 86,
    //       height: 94,
    //     ),
    //     Positioned(
    //       top: 5,
    //       child: ClipRRect(
    //         borderRadius: BorderRadius.circular(3.0),
    //         child: Image.network(
    //           imageUrl,
    //           width: 72,
    //           height: 72,
    //           fit: BoxFit.cover,
    //           errorBuilder: (context, error, stackTrace) {
    //             return const Icon(Icons.error, size: 72);
    //           },
    //           // loadingBuilder: (context, child, loadingProgress) {
    //           //   if (loadingProgress == null) return child;
    //           //   return const CircularProgressIndicator();
    //           // },
    //         ),
    //       ),
    //     ),
    //   ],
    // ),
  );

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

Color _getImageMarkerColor(String? eventType) {
  switch (eventType) {
    case 'FIRE':
      return const Color(0xFFFF3535);
    case 'TYPHOON':
      return const Color(0xFFAA3DC2);
    case 'FLOOD':
      return const Color(0xFF0046AE);
    case 'WAR':
      return const Color(0xFF16AE0B);
    case 'OTHER':
      return const Color(0xFFF28C2C);
    case 'CAR_ACCIDENT':
      return const Color(0xFF00A392);
    default:
      return const Color(0xFF6398E9);
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();

    const curveRadius = 1;

    path.moveTo(size.width / 2, size.height - curveRadius); // 하단 꼭짓점

    path.quadraticBezierTo(
      size.width / 2, // Control point x
      size.height, // Control point y (최하단)
      size.width / 2 + curveRadius, // End point x
      size.height - curveRadius, // End point y
    );

    path.lineTo(size.width, 0); // 삼각형 오른쪽으로 선 그음
    path.lineTo(0, 0); // 왼쪽으로,,

    // bottom left 라운딩
    path.lineTo(size.width / 2 - curveRadius, size.height - curveRadius);

    // 둥근 하단 모서리 되게,,
    path.quadraticBezierTo(
      size.width / 2, // Control point x
      size.height, // Control point y
      size.width / 2 - curveRadius, // End point x
      size.height - curveRadius, // End point y
    );

    // final path = Path()
    // ..moveTo(size.width / 2, size.height) // Bottom center of the triangle
    // ..lineTo(offset, 0) // Top left corner
    // ..lineTo(size.width - offset, 0) // Top right corner
    // // ..quadraticBezierTo(
    // //   size.width / 2,
    // //   size.height - offset, // Control point for curve
    // //   offset,
    // //   0, // Curve back to the bottom center
    // // )
    // ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
