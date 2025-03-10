import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import '../constants/ApiConstant.dart';
import '../models/Categories.dart';
import '../models/MemoryModel.dart';
import '../services/ApiServices.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';

class MyMemoryController extends GetxController {
  RxList<String> by_me_images = <String>[].obs;
  RxList<String> for_me_images = <String>[].obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    categories.add(CategoryModel(sId: "all", name: "All"));
    await fetchMemories();
    fetchCategories();
  }

  RxString selectedFilter = "Created By You".obs;

  Future<void> changeCatagory(CategoryModel value) async {
    if (selectedCatagory.value != value) {
      selectedCatagory.value = value;
      await fetchMemories();
    }
  }

  Future<void> fetchMemories() async {
    isLoading.value = true;
    try {
      const endpoint = ApiConstants.getAllMemories;
      Response? response =
          await ApiService.getRequest(endpoint, queryParameters: {
        "category": selectedCatagory.value?.sId ?? "all",
        "createdForYou":
            selectedFilter.value == "Created For You" ? "true" : "false"
      });
      List<dynamic> jsonMemories = response!.data["memories"];
      // final HomeScreenController homeController = Get.find();
      by_me_images.clear();
      for_me_images.clear();
      for (var item in jsonMemories) {
        if (selectedFilter.value == "Created By You") {
          by_me_images.add(item["files"][0]);
        } else {
          for_me_images.add(item["files"][0]);
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> fetchMemoryAndPassItToDetailScreen(String? imageKey) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      Response? response = await ApiService.postRequest(
          ApiConstants.getMemoryDetailByImage, {"file": imageKey});
      if (response != null) {
        Get.back();
        final memory = MemoryModel.fromJson(response.data);
        Get.toNamed(
          MemoryDetailScreen.routeName,
          arguments: memory,
        );

        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      Get.back();
      isLoading.value = false;
    }
  }

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCatagory = Rx<CategoryModel?>(null);
  RxBool isCategoriesLoading = false.obs;

  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;
    try {
      Response? response =
          await ApiService.getRequest(ApiConstants.getcategories);
      final Map<String, dynamic> jsonMap = jsonDecode(response!.toString());

      //ColoredPrint.green(jsonMap['data']['categories'].toString());
      for (var element in jsonMap['data']['categories']) {
        categories.add(CategoryModel.fromJson(element));
      }
      //ColoredPrint.green(categories[1].toString());
      isCategoriesLoading.value = false;
    } on DioException catch (e) {
      if (e.response != null) {
        Get.snackbar("ERROR", e.toString());
      } else {
        Get.snackbar("ERROR", "Some thing Went wrong");
      }
      isCategoriesLoading.value = false;
    }
  }
}
