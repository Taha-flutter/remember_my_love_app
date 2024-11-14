import 'package:dio/dio.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

import '../constants/ApiConstant.dart';
import 'Auth_services.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  static Future<Map<String, String>> _getHeaders() async {
    String? authToken = await _getAuthToken();
    return {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };
  }

  static Future<String?> _getAuthToken() async {
    return authService.authToken;
  }

  static Future<Response?> getRequest(String endpoint) async {
    try {
      final headers = await _getHeaders();
      Response response =
          await _dio.get(endpoint, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  static Future<Response?> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final headers = await _getHeaders();
      final Response response = await _dio.post(endpoint,
          data: data, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  static Future<Response?> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final headers = await _getHeaders();
      final response = await _dio.put(endpoint,
          data: data, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // Static DELETE request
  static Future<Response?> deleteRequest(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response =
          await _dio.delete(endpoint, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // Static error handler
  static void _handleError(DioException error) {
    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          Get.snackbar('Error', error.response!.data["message"]["error"][0]);
          break;
        case 401:
          Get.snackbar('Error', 'Unauthorized');
          break;
        case 404:
          Get.snackbar('Error', 'Not found');
          break;
        case 500:
          Get.snackbar('Error', 'Server error');
          break;
        default:
          Get.snackbar('Error', 'Something went wrong');
      }
    } else {
      Get.snackbar('Error', 'Check your internet connection');
    }
  }
}
