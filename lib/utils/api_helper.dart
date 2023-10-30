import 'package:dio/dio.dart';
import 'package:master_clinic_flutter_app/utils/request_interceptor.dart';
import './constants.dart';

class ApiHelper {
  String base = Constants.API_BASE;

  static Dio createDio() {
    Dio dio = Dio();
    dio.options.baseUrl = Constants.API_BASE;
    dio.options.contentType = Headers.jsonContentType;
    dio.interceptors.add(RequestInterceptor());
    return dio;
  }

  static Future<Response?> sendPostRequest(String url, Map<String, Map<String, String>> body) async {
    final dio = createDio();

    try {
      return await dio.post(
        url,
        data: body,
      );
    } on DioException catch (error) {
      return handleBadResponse(error);
    }
  }

  static Future<Response?> sendGetRequest(String url) async {
    final dio = createDio();

    try {
      return await dio.get(
        url,
      );
    } on DioException catch (error) {
      return handleBadResponse(error);
    }
  }

  static Future<Response?> sendDeleteRequest(String url) async {
    final dio = createDio();

    try {
      return await dio.delete(
        url,
      );
    } on DioException catch (error) {
      return handleBadResponse(error);
    }
  }

  static Response? handleBadResponse(DioException error) {
    print(error);
    final response = error.response;
    if (response != null) {
      return response;
    }
    print(error.message);
    return null;
  }

  // routes
  static String authLogin() {
    return 'users/sign_in.json';
  }

  static String authLogout() {
    return 'users/sign_out.json';
  }

  static String doctorsShow(String id) {
    return 'doctors/$id';
  }

  static String patientsShow(String id) {
    return 'patients/$id';
  }
}
