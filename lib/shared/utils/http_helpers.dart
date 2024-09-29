// 파싱 에러나 토큰 관련 에러는 여기서 처리 안해줌

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sos/shared/utils/log_util.dart';

// status codes and logging 용 헬퍼메소드
bool handleResponse(http.Response response, String methodName) {
  final resBody = jsonDecode(response.body);

  if (resBody['statusCode'] == 200) {
    LogUtil.d('$methodName 성공: ${resBody.toString()}');
    return true;
  } else if (resBody['statusCode'] == 400) {
    LogUtil.e('$methodName handleResponse 에러: ${resBody.toString()}');
    return false;
  } else {
    LogUtil.e(
        '$methodName handleResponse 에려: ${response.statusCode}, body: ${resBody.toString()}');
    return false;
  }
}

// GET 요청과 응답 처리용 헬퍼메소드
Future<http.Response> makeGetRequest(Uri url, String methodName,
    {String? accessToken}) async {
  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(url, headers: headers);

  if (!handleResponse(response, methodName)) {
    throw Exception('$methodName: Bad Response');
  }

  return response;
}

// 검색용 GET 요청 (false인 경우 에러 처리 안함)
Future<http.Response> makeGetRequestForSearch(Uri url, String methodName,
    {String? accessToken}) async {
  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(url, headers: headers);

  return response;
}

// POST 요청과 응답 처리용 헬퍼메소드
Future<http.Response> makePostRequest(
    Uri url, Map<String, dynamic>? body, String methodName,
    {String? accessToken}) async {
  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.post(
    url,
    headers: headers,
    body: body != null
        ? jsonEncode(body)
        : null, // Only encode if body is not null
  );

  if (!handleResponse(response, methodName)) {
    final resBody = jsonDecode(response.body);
    if (resBody["statusCode"] == 400) {
      throw Exception('${resBody["message"]}');
    }
    throw Exception('$methodName: Bad Response');
  }

  return response;
}

// PATCH 요청과 응답 처리용 헬퍼메소드
Future<http.Response> makePatchRequest(
    Uri url, Map<String, dynamic>? body, String methodName,
    {String? accessToken}) async {
  final headers = {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  final response = await http.patch(
    url,
    headers: headers,
    body: body != null
        ? jsonEncode(body)
        : null, // Only encode if body is not null
  );

  if (!handleResponse(response, methodName)) {
    throw Exception('$methodName: Bad Response');
  }

  return response;
}

// Multipart 헬퍼메소드
Future<http.Response> makeMultipartRequest(
    Uri url, Map<String, String?> fields, String methodName, String? filePath,
    {String? accessToken, String method = 'POST'}) async {
  try {
    var request = http.MultipartRequest(method, url);

    // request.fields.addAll(fields);
    fields.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value;
      }
    });

    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    if (filePath != null && filePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('media', filePath));
    }

    final response = await request.send();
    final resData = await http.Response.fromStream(response);

    if (!handleResponse(resData, methodName)) {
      throw Exception('$methodName: Bad Response');
    }

    return resData;
  } catch (e) {
    LogUtil.e('$methodName 에러: $e');
    throw Exception('$methodName: Multipart request 실패');
  }
}
