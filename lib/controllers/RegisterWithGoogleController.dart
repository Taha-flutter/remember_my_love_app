import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/Auth_services.dart';
import '../utills/Colored_print.dart';
import '../utills/CustomSnackbar.dart';
import '../view/screens/onboarding_screens/Questions_screen.dart';

class RegisterWithGoogleController extends GetxController {
  RxBool isLoading = true.obs;
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> signup() async {
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    // try {
    //   await authService.registerwithgoogle(
    //     contactController.text.trim(),
    //     nameController.text.trim(),
    //   );

    //   Get.back();
    //   CustomSnackbar.showSuccess("Success", "Signup Successful");
    //   Get.offNamed(QuestionsScreen.routeName);
    // } catch (e) {
    //   ColoredPrint.red(e.toString());
    //   Get.back();
    //   CustomSnackbar.showError("Error", e.toString());
    // }
  }
}