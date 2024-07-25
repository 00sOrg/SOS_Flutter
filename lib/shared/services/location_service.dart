import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:nearhere/shared/models/location.dart';

class LocationService {
  Future<Location> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    final lat = position.latitude;
    final lon = position.longitude;

    final headers = {
      'X-NCP-APIGW-API-KEY-ID': dotenv.env['NAVER_MAP_API_ID']!,
      'X-NCP-APIGW-API-KEY': dotenv.env['NAVER_MAP_API_SECRET']!,
    };

    final response = await http.get(
      Uri.parse(
        // "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coordsToaddr&coords=${lon},${lat}&sourcecrs=epsg:4326&output=json",
        "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$lon,$lat&sourcecrs=epsg:4326&orders=legalcode,admcode,addr,roadaddr&output=json",
      ),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load location data: ${response.reasonPhrase}");
    }

    final jsonData = jsonDecode(response.body);
    // print('[[SUCESS]] Naver Map API Response: $jsonData');

    if (jsonData["results"] == null || jsonData["results"].isEmpty) {
      throw RangeError("No results found in the response");
    }

    String adminAddress = '';
    String roadAddress = '';

    for (var result in jsonData["results"]) {
      if (result["name"] == "roadaddr") {
        roadAddress = result["region"]["area1"]["name"] +
            ' ' +
            result["region"]["area2"]["name"] +
            ' ' +
            result["land"]["name"] +
            ' ' +
            result["land"]["number1"];
        if (result["land"]["addition0"] != null) {
          // ignore: prefer_interpolation_to_compose_strings
          roadAddress += ' ' + result["land"]["addition0"]["value"];
        }
      } else if (result["name"] == "addr") {
        adminAddress = result["region"]["area1"]["name"] +
            ' ' +
            result["region"]["area2"]["name"] +
            ' ' +
            result["region"]["area3"]["name"];
      }
    }

    if (adminAddress.isEmpty || roadAddress.isEmpty) {
      throw RangeError("Could not find the required addresses in the response");
    }

    return Location(
      latitude: lat,
      longitude: lon,
      adminAddress: adminAddress,
      roadAddress: roadAddress,
    );
  }
}

//     final region = jsonData["results"][0]["region"];
//     final myJsonGu = region["area2"]["name"];
//     final myJsonSi = region["area1"]["name"];
//     // print('############# region: $region');
//     // print('############# myJsonGu: $myJsonGu');
//     // print('############# myJsonGu: $myJsonGu');

//     final address = '$myJsonSi $myJsonGu';

//     return Location(
//       latitude: lat,
//       longitude: lon,
//       address: address,
//     );
//   }
// }
