import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/models/SearchUserModel.dart';
import 'package:remember_my_love_app/utills/Validators.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Schedule_memory_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:searchfield/searchfield.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/colors_constants.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/Upload_memory_controller.dart';
import '../../../../widgets/Custom_glass_container.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';
import '../../../../widgets/Glass_text_field_with_text_widget.dart';

class RecipientDetailsScreen extends GetView<UploadMemoryController> {
  RecipientDetailsScreen({super.key});
  static const routeName = "RecipientDetailsScreen";
  final _formKey = GlobalKey<FormState>();
  Timer? _debounceTimer;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  CustomRoundedGlassButton(
                      icon: Icons.arrow_back_ios_new, ontap: () => Get.back()),
                  k2wSizedBox,
                  Text(
                    "Recipient's Details",
                    style: TextStyleConstants.headlineLargeWhite(context),
                  )
                ],
              ),
              CustomGlassmorphicContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Send To",
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          _showDropdown(context);
                        },
                        child: CustomGlassmorphicContainer(
                            borderRadius: 8,
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 2.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  return Text(controller.sendTo.value);
                                }),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColors.kIconColor,
                                )
                              ],
                            )),
                      ),
                    ),
                    k1hSizedBox,
                    Obx(() {
                      return controller.sendTo == "self"
                          ? SizedBox.shrink()
                          : Column(
                              children: List.generate(
                                  controller.recipients.length, (index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Recipient 0${index + 1}",
                                            style: TextStyleConstants
                                                    .bodyMediumWhite(context)
                                                .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          IconButton(
                                            color: AppColors.kGlassColor,
                                            onPressed: () {
                                              controller.removeRecipient(index);
                                            },
                                            icon: const Icon(Icons.remove),
                                          )
                                        ],
                                      ),
                                    ),
                                    k1hSizedBox,
                                    GlassTextFieldWithTitle(
                                      title: 'Enter Relation',
                                      hintText: "Family, Friend, Sibling, etc",
                                      controller: controller.recipientRelation,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        }
                                        return null;
                                      },
                                    ),
                                    k1hSizedBox,
                                    Text("Email"),
                                    k1hSizedBox,
                                    SearchField<SearchUserModel>(
                                      onSearchTextChanged: (value) {
                                        if (_debounceTimer != null) {
                                          _debounceTimer?.cancel();
                                        }

                                        _debounceTimer = Timer(
                                            Duration(milliseconds: 1000), () {
                                          controller.getAvailableUsers(value);
                                        });
                                      },
                                      suggestionItemDecoration: BoxDecoration(
                                        color: AppColors.kGlassColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      suggestionsDecoration:
                                          SuggestionDecoration(
                                        color: AppColors.kGlassColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      onSuggestionTap:
                                          (SearchFieldListItem<SearchUserModel>
                                              x) {
                                        controller
                                            .recipients[index]
                                            .emailController
                                            .text = x.item?.email ?? "";
                                      },
                                      hint: "Enter Email",
                                      validator: (value) {
                                        emailValidator(value);
                                      },
                                      controller: controller
                                          .recipients[index].emailController,
                                      suggestions: controller.allAvailableUsers
                                          .map(
                                            (e) => SearchFieldListItem<
                                                SearchUserModel>(
                                              e.email ?? "",
                                              item: e,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  e.email ?? "",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    k1hSizedBox,
                                    GlassTextFieldWithTitle(
                                      title: 'Contact',
                                      hintText: "Enter Phone Number",
                                      keyboardType: TextInputType.phone,
                                      controller: controller
                                          .recipients[index].contactController,
                                      validator: (value) {
                                        phoneNumberValidator(value);
                                      },
                                    ),
                                  ],
                                );
                              }),
                            );
                    }),
                    k1hSizedBox,
                    Obx(() {
                      return controller.sendTo == "self"
                          ? SizedBox.shrink()
                          : Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  controller.addRecipient();
                                },
                                child: Text(
                                  "Add More Recipients +",
                                  style: TextStyleConstants.bodyMediumWhite(
                                          context)
                                      .copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            );
                    }),
                  ],
                ),
              ),
              k2hSizedBox,
              GradientButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.toNamed(ScheduleMemoryScreen.routeName);
                    }
                  },
                  text: "Send",
                  gradients: const [Colors.purple, Colors.blue]),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showMenu(
      color: AppColors.kGlassColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          50.w, 20.h, 8.w, 0.0), // Adjust position if needed
      items: <String>[
        'self',
        'others',
      ].map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Container(
            color: Colors.transparent, // Semi-transparent background
            padding: const EdgeInsets.all(10),
            child: Text(
              value,
              style: TextStyleConstants.bodySmallWhite(
                  context), // White text for contrast
            ),
          ),
        );
      }).toList(),
    ).then((String? newValue) {
      if (newValue != null) {
        controller.sendTo.value = newValue;
        print(newValue);
      }
    });
  }
}
