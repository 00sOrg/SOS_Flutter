import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<Map<String, dynamic>> fetchLocationData(double lat, double lon) async {
    final String baseGeoUrl = dotenv.env['NAVER_REVERSE_GEOCODE_URL']!;
    final String fullUrl =
        '$baseGeoUrl?coords=$lon,$lat&sourcecrs=epsg:4326&orders=legalcode,admcode,addr,roadaddr&output=json';

    final headers = {
      'X-NCP-APIGW-API-KEY-ID': dotenv.env['NAVER_MAP_API_ID']!,
      'X-NCP-APIGW-API-KEY': dotenv.env['NAVER_MAP_API_SECRET']!,
    };

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load location data: ${response.reasonPhrase}");
    }

    final jsonData = jsonDecode(response.body);
    // log('[[SUCCESS]] Naver Map API Response: $jsonData');

    if (jsonData["results"] == null || jsonData["results"].isEmpty) {
      throw RangeError("No results found in the response");
    }

    return jsonData;
  }

  // 주소를 좌표로 변환하는 검색 메소드 추가
  Future<Map<String, dynamic>> searchLocationByAddress(String address) async {
    final String baseGeocodeUrl = dotenv.env['NAVER_GEOCODE_URL']!;
    final String fullUrl =
        '$baseGeocodeUrl?query=${Uri.encodeComponent(address)}&output=json';

    final headers = {
      'X-NCP-APIGW-API-KEY-ID': dotenv.env['NAVER_MAP_API_ID']!,
      'X-NCP-APIGW-API-KEY': dotenv.env['NAVER_MAP_API_SECRET']!,
    };

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to search location: ${response.reasonPhrase}");
    }

    final jsonData = jsonDecode(response.body);

    if (jsonData["addresses"] == null || jsonData["addresses"].isEmpty) {
      throw RangeError("No results found for the given address");
    }

    return jsonData;
  }

  // 좌표로 주소를 구하는 메소드 추가 (역지오코딩)
  Future<String> getAddressByCoordinates(
      double latitude, double longitude) async {
    final String baseGeoUrl = dotenv.env['NAVER_REVERSE_GEOCODE_URL']!;
    final String fullUrl =
        '$baseGeoUrl?coords=$longitude,$latitude&sourcecrs=epsg:4326&orders=roadaddr,addr&output=json';

    final headers = {
      'X-NCP-APIGW-API-KEY-ID': dotenv.env['NAVER_MAP_API_ID']!,
      'X-NCP-APIGW-API-KEY': dotenv.env['NAVER_MAP_API_SECRET']!,
    };

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception(
          "Failed to fetch address from coordinates: ${response.reasonPhrase}");
    }

    final jsonData = jsonDecode(response.body);

    // 응답 로그 출력 (디버깅용)
    //print('Naver API Response: $jsonData');

    if (jsonData["results"] == null || jsonData["results"].isEmpty) {
      throw RangeError("No address found for the given coordinates");
    }

    // 'land' 정보가 없는 경우에는 'region' 정보로 주소를 구성
    final land = jsonData["results"][0]["land"];
    final region = jsonData["results"][0]["region"];

    // 도로명 주소나 지번 주소가 없는 경우, 'region' 정보를 활용해 주소 구성
    final roadAddress = land?["roadAddress"];
    final jibunAddress = land?["address"];

    if (roadAddress != null) {
      return roadAddress;
    } else if (jibunAddress != null) {
      return jibunAddress;
    } else {
      // 'region' 정보로 기본 주소 구성 (시, 구, 동 정보)
      final area1 = region["area1"]["name"]; // 예: 경기도
      final area2 = region["area2"]["name"]; // 예: 수원시 영통구
      final area3 = region["area3"]["name"]; // 예: 영통동

      return '$area1 $area2 $area3';
    }
  }
}
