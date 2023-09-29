import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static String base = '127.0.0.1:3000';

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

  // routes
  static Uri authLogin = Uri.http(base, 'users/sign_in.json');
  static Uri authLogout = Uri.http(base, 'users/sign_out.json');
}
