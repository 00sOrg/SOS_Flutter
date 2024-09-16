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
}
