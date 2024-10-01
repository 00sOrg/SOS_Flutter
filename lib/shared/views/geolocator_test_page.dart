import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:sos/shared/services/geolocator_service.dart';

class GeolocatorTestPage extends StatefulWidget {
  const GeolocatorTestPage({Key? key}) : super(key: key);

  @override
  _GeolocatorTestPageState createState() => _GeolocatorTestPageState();
}

class _GeolocatorTestPageState extends State<GeolocatorTestPage> {
  String _output = '버튼 클릭 ㄱㄱ';
  List<String> _locationLog = [];
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;

  @override
  void dispose() {
    // Cancel the stream subscriptions when the widget is disposed
    _positionStreamSubscription?.cancel();
    _serviceStatusStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocator Service Test'),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            btn(
              onPressed: _getCurrentPosition,
              child: '현재 위치 불러오기',
            ),
            btn(
              onPressed: _getLastKnownPosition,
              child: '마지막으로 알고있는 위치 불러오기',
            ),
            btn(
              onPressed: _startListeningToLocationUpdates,
              child: 'Location Update Listening 시작',
              color: Colors.black,
            ),
            btn(
              onPressed: _stopListeningToLocationUpdates,
              child: 'Location Update Listening 끝',
            ),
            btn(
              onPressed: _checkLocationServiceStatus,
              child: 'Location Service 상태 확인',
            ),
            btn(
              onPressed: _checkPermissionStatus,
              child: '위치 권한 상태 확인 - always 여야함',
            ),
            btn(
              onPressed: _requestPermission,
              child: 'Permission 요청',
            ),
            btn(
              onPressed: _checkLocationAccuracy,
              child: 'Location 정확도 확인',
            ),
            btn(
              onPressed: _listenToServiceStatusStream,
              child: 'Listen to Service Status Changes',
              color: Colors.green,
            ),
            btn(
              onPressed: _openSettings,
              child: '위치 권한 수정',
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _locationLog.length,
                itemBuilder: (context, index) {
                  return Text(
                    _locationLog[index],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setOutput(String text) {
    setState(() {
      _output = text;
    });
  }

  void _logLocation(String text) {
    setState(() {
      _locationLog.add(text);
    });
  }

  Future<void> _getCurrentPosition() async {
    try {
      Position position = await GeolocatorService.getCurrentPosition();
      _setOutput(
          'Current Position: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      _setOutput('Error: $e');
    }
  }

  Future<void> _getLastKnownPosition() async {
    try {
      Position? position = await GeolocatorService.getLastKnownPosition();
      if (position != null) {
        _setOutput(
            'Last Known Position: ${position.latitude}, ${position.longitude}');
      } else {
        _setOutput('No Last Known Position available.');
      }
    } catch (e) {
      _setOutput('Error: $e');
    }
  }

  void _startListeningToLocationUpdates() {
    _positionStreamSubscription = GeolocatorService.getPositionStream(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen(
      (Position position) {
        final positionString =
            'Position Update: ${position.latitude}, ${position.longitude}';
        _setOutput(positionString);
        _logLocation(positionString);

        debugPrint(
            'Position Update: ${position.latitude}, ${position.longitude}');
      },
      onError: (e) {
        _setOutput('Error: $e');
      },
      onDone: () {
        _setOutput('Location stream closed.');
      },
    );
  }

  void _stopListeningToLocationUpdates() {
    _positionStreamSubscription?.cancel();
    _setOutput('Stopped listening to location updates');
  }

  Future<void> _checkLocationServiceStatus() async {
    bool isEnabled = await GeolocatorService.isLocationServiceEnabled();
    _setOutput('Location Service Enabled: $isEnabled');
  }

  Future<void> _checkPermissionStatus() async {
    LocationPermission permission = await GeolocatorService.checkPermission();
    _setOutput('Location Permission Status: $permission');
  }

  Future<void> _requestPermission() async {
    LocationPermission permission = await GeolocatorService.requestPermission();
    _setOutput('Permission Requested: $permission');
  }

  Future<void> _openSettings() async {
    bool openSet = await GeolocatorService.openAppSettings();
    _setOutput('openSettings: $openSet');
  }

  Future<void> _checkLocationAccuracy() async {
    LocationAccuracyStatus accuracyStatus =
        await GeolocatorService.getLocationAccuracy();
    _setOutput('Location Accuracy: $accuracyStatus');
  }

  void _listenToServiceStatusStream() {
    _serviceStatusStreamSubscription =
        GeolocatorService.getServiceStatusStream().listen(
      (ServiceStatus status) {
        _setOutput('Service Status: $status');
        _logLocation('Service Status: $status');
      },
      onError: (e) {
        _setOutput('Error: $e');
      },
    );
  }

  Widget btn({
    required VoidCallback onPressed,
    required String child,
    Color? color,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
      ),
      onPressed: onPressed,
      child: Text(
        child,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
