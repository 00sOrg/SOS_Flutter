import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:sos/shared/models/location.dart';

class MapWidget extends StatelessWidget {
  final Location location;

  const MapWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(location.latitude, location.longitude),
          zoom: 15,
          bearing: 0,
          tilt: 0,
        ),
      ),
      onMapReady: (controller) {
        debugPrint('[[SUCCESS]] 네이버 지도 로딩 \n');
      },
    );
  }
}

class DummyMapArea extends StatelessWidget {
  const DummyMapArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
    );
  }
}