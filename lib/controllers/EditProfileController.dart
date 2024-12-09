import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/ApiConstant.dart';
import '../constants/constants.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import 'HomeScreenController.dart';

class EditProfileController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    homeScreenController = Get.find();
  }

  // TextEditingController nameController = TextEditingController(text: homeScreenController.user.value?.name);
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  late HomeScreenController homeScreenController;

  RxBool isLoading = false.obs;
  RxBool isImageUploading = false.obs;

  Future<void> upateMe() async {
    isLoading.value = true;
    try {
      Response? response =
          await ApiService.patchRequest(ApiConstants.updateUserDetails, {
        "name": nameController.value.text.isEmpty
            ? homeScreenController.user.value?.name ?? ""
            : nameController.value.text,
        "email": emailController.value.text.isEmpty
            ? homeScreenController.user.value?.email ?? ""
            : emailController.value.text,
        "username": userNameController.value.text.isEmpty
            ? homeScreenController.user.value?.username ?? ""
            : userNameController.value.text,
        "contact": contactController.value.text.isEmpty
            ? homeScreenController.user.value?.contact ?? ""
            : contactController.value.text,
        "photo": homeScreenController.user.value?.photo
      });
      if (response != null) {
        // homeScreenController.Saveuser(response.data);
        homeScreenController.getUSer();
        isLoading.value = false;
        Get.back();
        CustomSnackbar.showSuccess("Success", "Profile Updated Successfully");
        // Get.back();
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> upateImage(String? key) async {
    isImageUploading.value = true;
    try {
      Response? response = await ApiService.patchRequest(
          ApiConstants.updateUserDetails, {"photo": key});
      if (response != null) {
        // homeScreenController.Saveuser(response.data);
        homeScreenController.getUSer();
        isImageUploading.value = false;
        Get.back();
        CustomSnackbar.showSuccess("Success", "Profile Updated Successfully");
        // Get.back();
      }
    } catch (e) {
      isImageUploading.value = false;
      CustomSnackbar.showError("Error", "Profile Updated Faild");
    }
  }

  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> pickedFile = Rx<XFile?>(null);
  Map<String, dynamic>? imageUploadMimType;

  // Function to show the dialog box for camera/gallery selection

  void showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 2, 255, 242).withOpacity(0.3),
                  const Color.fromARGB(255, 255, 0, 238).withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 0,
                    sigmaY: 13,
                    tileMode: TileMode.mirror), // Apply the blur effect
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Upload Image',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      k2hSizedBox,
                      Text(
                        'Please select the image source',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      k1hSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              _pickImage(ImageSource.camera);
                              Get.back();
                            },
                            child: Text(
                              'Camera',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _pickImage(ImageSource.gallery);
                              Get.back();
                            },
                            child: Text(
                              'Gallery',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);

    if (file != null) {
      pickedFile.value = file;
    }
  }

  Future<void> uploadMimeTypes() async {
    isImageUploading.value = true;
    try {
      // Get the MIME type for each picked file
      final mimeTypes = lookupMimeType(pickedFile.value!.path);

      ColoredPrint.green(mimeTypes.toString());
      Response? response = await ApiService.postRequest(
        ApiConstants.uploadMimTypes,
        {
          "mimeTypes": [mimeTypes],
        },
      );

      ColoredPrint.green(response.toString());

      if (response?.statusCode == 201 && response != null) {
        final jsonresponse = response.data;
        imageUploadMimType = jsonresponse["data"][0];

        await uploadToS3Bucket(
            imageUploadMimType, mimeTypes ?? "application/octet-stream");

        pickedFile.value = null;
        isImageUploading.value = false;
      }
    } catch (e) {
      isImageUploading.value = false;
      ColoredPrint.red("Error uploading image: $e");
    }
  }

  uploadToS3Bucket(
      Map<String, dynamic>? imageUploadData, String mimeType) async {
    String contentType =
        lookupMimeType(pickedFile.value!.path) ?? "application/octet-stream";
    try {
      final fileBytes = await pickedFile.value!.readAsBytes();
      final response = await Dio().put(
        imageUploadData!["url"],
        data: fileBytes,
        options: Options(
          headers: {
            "Content-Type": mimeType,
          },
        ),
      );

      // Handle the response
      if (response.statusCode == 200) {
        await upateImage(imageUploadData["key"]);

        ColoredPrint.green("Image uploaded successfully:");
      } else {
        ColoredPrint.red("Failed to upload image: ${response.statusCode}");
      }
    } catch (e) {
      ColoredPrint.red("Error uploading image: $e");
    }
  }
}