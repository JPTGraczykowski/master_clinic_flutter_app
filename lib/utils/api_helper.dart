import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:master_clinic_flutter_app/main.dart';
import 'package:master_clinic_flutter_app/utils/request_interceptor.dart';
import '../screens/sign_in.dart';
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

  static Future<Response?> sendPostRequest(String url, Map<String, Map<String, dynamic>> body) async {
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

  static Future<Response?> sendPatchRequest(String url, Map<String, Map<String, dynamic>> body) async {
    final dio = createDio();

    try {
      return await dio.patch(
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
      if (response.statusCode == 401) {
        navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }
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

  static String doctorsShow(int id) {
    return 'doctors/$id';
  }

  static String patientsShow(int id) {
    return 'patients/$id';
  }

  // Appointments
  static String appointmentsIndex() {
    return 'appointments';
  }

  static String appointmentShow(int id) {
    return 'appointments/${id.toString()}';
  }

  static String appointmentCreate() {
    return 'appointments';
  }

  static String appointmentUpdate(int id) {
    return 'appointments/${id.toString()}';
  }

  // Cabinets
  static String cabinetsIndex() {
    return 'cabinets';
  }

  // DatetimeSlots
  static String datetimeSlotIndex() {
    return 'datetime_slots';
  }

  static String datetimeSlotShow(int id) {
    return 'datetime_slots/${id.toString()}';
  }

  static String datetimeSlotCreate() {
    return 'datetime_slots';
  }

  static String datetimeSlotUpdate(int id) {
    return 'datetime_slots/${id.toString()}';
  }

  static String datetimeSlotDelete(int id) {
    return 'datetime_slots/${id.toString()}';
  }

  // selectors routes
  static String specialties() {
    return 'selectors/specialties';
  }

  static String doctors({int? specialtyId}) {
    return 'selectors/doctors${specialtyId != null ? '?specialty_id=$specialtyId' : ''}';
  }

  static String patients() {
    return 'selectors/patients';
  }

  static String datetimeSlots({int? doctorId}) {
    return 'selectors/datetime_slots${doctorId != null ? '?doctor_id=$doctorId' : ''}';
  }

  static String cabinets({int? doctorId}) {
    return 'selectors/cabinets${doctorId != null ? '?doctor_id=$doctorId' : ''}';
  }
}
