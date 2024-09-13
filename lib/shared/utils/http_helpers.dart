// auth 기준으로 만들어서 다른 데 쓰려면 수정 필요할수도 있음,, 매우높은확률로

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sos/shared/utils/log_util.dart';

// status codes and logging 용 헬퍼메소드
bool handleResponse(http.Response response, String methodName) {
  final resBody = jsonDecode(response.body);

  if (resBody['statusCode'] == 200) {
    LogUtil.d(resBody.toString());
    return true;
  } else if (resBody['statusCode'] == 400) {
    LogUtil.e('$methodName 에러: ${resBody.toString()}');
    return false;
  } else {
    LogUtil.e(
        '$methodName 에려: ${response.statusCode}, body: ${resBody.toString()}');
    throw Exception('$methodName: Unexpected response from server');
  }
}

// GET 요청과 응답 처리용 헬퍼메소드
Future<bool> makeGetRequest(Uri url, String methodName) async {
  try {
    final response = await http.get(url);
    return handleResponse(response, methodName);
  } catch (e) {
    LogUtil.e('GET $methodName 에러: $e');
    return false;
  }
}

// POST 요청과 응답 처리용 헬퍼메소드
Future<bool> makePostRequest(
    Uri url, Map<String, dynamic> body, String methodName) async {
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return handleResponse(response, methodName);
  } catch (e) {
    LogUtil.e('$methodName 에러: $e');
    return false;
  }
}
