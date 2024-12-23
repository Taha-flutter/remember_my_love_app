import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import 'package:remember_my_love_app/services/FirebaseServices.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/RegisterWithGoogle.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/Splash_screen.dart';
import '../constants/ApiConstant.dart';

import 'ApiServices.dart';
import 'Auth_token_services.dart';
import 'LocalAuthServices.dart';

class AuthService extends GetxService {
  @override
  void onInit() async {
    await initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    print("Initializing AuthService...");
    if (await _tokenStorage.hasToken()) {
      isAuthenticated.value = true;
      authToken = await _tokenStorage.getToken();

      print("User is authenticated with token: $authToken");
    }
  }

  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  var isAuthenticated = false.obs;
  var platform = "".obs;
  final TokenService _tokenStorage = TokenService();

  String? authToken;

  // Biometric authentication function
  Future<bool?> loginWithFingerPrint() async {
    final authenticated = await LocalAuthService.authenticateUser();

    // Get
    if (authenticated) {
      try {
        Response response = await _dio.post(
          ApiConstants.verifyFingerPrint,
          data: {
            "validationKey": FirebaseService.fcmToken,
          },
        );
        if (response != null) {
          platform.value = "finger";
          authToken = response.data["data"]["token"];
          _tokenStorage.saveToken(authToken!);
          isAuthenticated.value = true;
          return true;
        } else {
          throw Exception("an error occured");
          // return false;
        }
      } on DioException catch (e) {
        throw Exception("an error occured");
        // if (e.response != null) {
        // CustomSnackbar.showError("Error",
        //     e.response?.data["message"]["error"][0] ?? "An error occurred");
        // return false;
        // } else {
        //   CustomSnackbar.showError("Error", "Network error: ${e.message}");
        //   return false;
        // }
      }
    } else {
      // false;
      throw Exception("an error occured");
    }
  }

  Future<bool?> loginWithGoogle() async {
    try {
      final user = await FirebaseService.signInWithGoogle();
      if (user != null) {
        final data = {
          "email": user.email,
          "displayName": user.displayName,
          "photo": user.photoURL,
          "fcmToken": FirebaseService.fcmToken,
          "validationKey": FirebaseService.fcmToken,
          "platform": "google"
        };

        Response response = await _dio.post(
          ApiConstants.socialLogin,
          data: {
            "email": user.email,
            "displayName": user.displayName,
            "photo": user.photoURL,
            "fcmToken": FirebaseService.fcmToken,
            "validationKey": FirebaseService.fcmToken,
            "platform": "google"
          },
        );

        if (response.data?["data"]?["user"]?["firstLogin"] ?? false) {
          Get.toNamed(RegisterwithgoogleScreen.routeName);
        }

        platform.value = "google";
        authToken = response.data["data"]["token"];
        _tokenStorage.saveToken(authToken!);
        return true;
      } else {
        throw Exception("an error occured");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"][0] ?? "An error occurred");
      } else {
        throw Exception("Network error: Check Your Internet Connection");
      }
    }
  }

  Future<Map<String, dynamic>?> Signup(
    String name,
    String userName,
    String email,
    String password,
    String passCnfrm,
  ) async {
    ColoredPrint.green("signup ${FirebaseService.fcmToken.toString()}");
    try {
      Response response = await _dio.post(
        ApiConstants.signup,
        data: {
          "name": name,
          "username": userName,
          "email": email,
          "password": password,
          "passwordConfirm": passCnfrm,
          "validationKey": FirebaseService.fcmToken,
          "fcmToken": FirebaseService.fcmToken
        },
      );
      platform.value = "email";
      authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!);
      isAuthenticated.value = true;
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"][0] ?? "An error occurred");
      } else {
        throw Exception("Network error Check your Internet Connection");
      }
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiConstants.login,
        data: {"email": email, "password": password},
      );
      platform.value = "email";
      authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!);
      isAuthenticated.value = true;
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error Check your Internet Connection");
      }
    }
  }

  Future<Map<String, dynamic>> forgotPassword(
    String email,
  ) async {
    try {
      Response response = await _dio.post(
        ApiConstants.forgotPass,
        data: {"email": email},
      );
      /* authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!); 
      isAuthenticated.value = true;*/
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: Check Your Internet Connection");
      }
    }
  }

  Future<Response> registerwithgoogle(String contact, String name) async {
    try {
      Response response = await _dio.patch(
        ApiConstants.updateUserDetails,
        data: {"contact": contact, "name": name},
      );
      platform.value = "google";
      authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!);
      return response;
    } catch (e) {
      ColoredPrint.red(e.toString());
      Get.back();
      throw e;
    }
  }

  Future<Map<String, dynamic>> verifyOnetime(String email, int code) async {
    try {
      Response response = await _dio.patch(
        ApiConstants.verifyOTP,
        data: {"email": email, "code": code},
      );
      /* authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!); 
      isAuthenticated.value = true;*/
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: Check Your Internet Connection");
      }
    }
  }

  Future<Map<String, dynamic>> resetPass(
      String email, int code, String password, String confirm_pass) async {
    try {
      Response response = await _dio.patch(
        ApiConstants.resetPass,
        data: {
          "email": email,
          "code": code,
          "password": password,
          "passwordConfirm": confirm_pass
        },
      );
      /* authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!); 
      isAuthenticated.value = true;*/
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: Check Your Internet Connection");
      }
    }
  }

  Future<void> logout() async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final Response? response =
          await ApiService.postRequest(ApiConstants.logout, {});
      if (platform == "apple") {
      } else if (platform == "google") {
        await FirebaseService.signOut();
      }
      if (response != null) {
        Get.back();
        deleteAuthtokenAndNavigate(message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: Check Your Internet Connection");
      }
    }
  }

  Future<void> deleteAccount(String userId) async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final Response? response =
          await ApiService.deleteRequest(ApiConstants.deleteUser + userId);
      ColoredPrint.red(response?.data?.toString() ?? "");

      if (response != null) {
        if (platform == "apple") {
        } else if (platform == "google") {
          await FirebaseService.signOut();
        }
        Get.back();
        deleteAuthtokenAndNavigate(message: response.data["data"]["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: Check Your Internet Connection");
      }
    }
  }

  Future<void> deleteAuthtokenAndNavigate({String? message}) async {
    await _tokenStorage.deleteToken();
    authToken = null;
    isAuthenticated.value = false;
    CustomSnackbar.showSuccess("Success", message ?? "Logged Out");
    Get.offAllNamed(SplashScreen.routeName);
  }
}

final AuthService authService = Get.find();
