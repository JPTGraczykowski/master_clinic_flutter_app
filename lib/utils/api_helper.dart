import 'dart:convert';
import 'package:http/http.dart' as http;
import './constants.dart';

class ApiHelper {
  static String base = Constants.API_BASE;

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static Future<http.Response> sendPostRequest(Uri url, Map<String, Map<String, String>> body) async {
    http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> sendGetRequest(Uri url) async {
    http.Response response = await http.get(
      url,
      headers: headers,
    );

    return response;
  }

  // routes
  static Uri authLogin() {
    return Uri.http(base, 'users/sign_in.json');
  }

  static Uri authLogout() {
    return Uri.http(base, 'users/sign_out.json');
  }

  static Uri doctorsShow(String id) {
    return Uri.http(base, 'doctors/$id');
  }

  static Uri patientsShow(String id) {
    return Uri.http(base, 'patients/$id');
  }
}
