import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/Upload_memory_screens/Recipient_details_screen.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:remember_my_love_app/view/screens/splash_screens/Splah_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/Glass_text_field_with_text_widget.dart';

class WriteAMemoryScreen extends StatelessWidget {
  const WriteAMemoryScreen({super.key});
  static const routeName = "WriteAMemoryScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Row(
            children: [
              CustomRoundedGlassButton(
                  icon: Icons.arrow_back_ios_new, ontap: () => Get.back()),
              k2wSizedBox,
              Text(
                "Write a Memory",
                style: TextStyleConstants.headlineLargeWhite(context),
              )
            ],
          ),
          CustomGlassmorphicContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassTextFieldWithTitle(
                  title: 'Title',
                  hintText: "Enter Title",
                ),
                k1hSizedBox,
                Text(
                  "Select Category",
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
                            Text("Catagory"),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.kIconColor,
                            )
                          ],
                        )),
                  ),
                ),
                Text("Description"),
                k1hSizedBox,
                SizedBox(
                  height: 20.h,
                  width: double.infinity,
                  child: TextField(
                    textAlignVertical: TextAlignVertical(y: -1.0),
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Enter Description",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          GradientButton(
              onPressed: () {
                Get.toNamed(RecipientDetailsScreen.routeName);
              },
              text: "Add Recipients",
              gradients: [Colors.purple, Colors.blue])
        ],
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showMenu(
      color: AppColors.kGlassColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      surfaceTintColor: Colors.amber,

      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          100.0, 0.0, 0.0, 100.0), // Adjust position if needed
      items: <String>['Option 1', 'Option 2', 'Option 3'].map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Container(
            color: Colors.transparent, // Semi-transparent background
            padding: EdgeInsets.all(10),
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
        print("Selected: $newValue");
      }
    });
  }
}