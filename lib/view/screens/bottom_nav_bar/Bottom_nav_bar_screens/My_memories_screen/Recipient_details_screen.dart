import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Schedule_memory_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/colors_constants.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/Upload_memory_controller.dart';
import '../../../../widgets/Custom_glass_container.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';
import '../../../../widgets/Glass_text_field_with_text_widget.dart';

class RecipientDetailsScreen extends GetView<UploadMemoryController> {
  const RecipientDetailsScreen({super.key});
  static const routeName = "RecipientDetailsScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
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
                  Obx(() {
                    return controller.sendTo.value == 'Other'
                        ? GlassTextFieldWithTitle(
                            title: 'Enter Relation',
                            hintText: "Family, Friend, Sibling, etc",
                            controller: controller.recipientRelation,
                          )
                        : const SizedBox();
                  }),
                  k1hSizedBox,
                  Obx(() {
                    return Column(
                      children:
                          List.generate(controller.recipients.length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Text(
                                    "Recipient 0${index + 1}",
                                    style: TextStyleConstants.bodyMediumWhite(
                                            context)
                                        .copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  IconButton(
                                      color: AppColors.kGlassColor,
                                      onPressed: () {
                                        controller.removeRecipient(index);
                                      },
                                      icon: const Icon(Icons.remove))
                                ],
                              ),
                            ),
                            k1hSizedBox,
                            GlassTextFieldWithTitle(
                              title: 'Email',
                              hintText: "Enter Email",
                              controller:
                                  controller.recipients[index].emailController,
                            ),
                            k1hSizedBox,
                            GlassTextFieldWithTitle(
                              title: 'Contact',
                              hintText: "Enter Phone Number",
                              controller: controller
                                  .recipients[index].contactController,
                            )
                          ],
                        );
                      }),
                    );
                  }),
                  k1hSizedBox,
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        controller.addRecipient();
                      },
                      child: Text(
                        "Add More Recipients +",
                        style: TextStyleConstants.bodyMediumWhite(context)
                            .copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  k1hSizedBox,
                  GlassTextFieldWithTitle(
                    title: 'Username',
                    hintText: "Enter Username",
                    controller: controller.recievingUsername,
                  ),
                  k1hSizedBox,
                  GlassTextFieldWithTitle(
                      title: 'Password',
                      hintText: "Enter Password",
                      controller: controller.recievingUserPassword)
                ],
              ),
            ),
            k2hSizedBox,
            GradientButton(
                onPressed: () {
                  Get.toNamed(ScheduleMemoryScreen.routeName);
                },
                text: "Send",
                gradients: const [Colors.purple, Colors.blue]),
          ],
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
        'same',
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
        // Handle dropdown value change
        controller.sendTo.value = newValue;
        print(newValue);
      }
    });
  }
}
