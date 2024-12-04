import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Write_a_memory.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../controllers/Upload_memory_controller.dart';

class UploadMemoryScreen extends GetView<UploadMemoryController> {
  const UploadMemoryScreen({super.key});
  static const routeName = "UploadMemoryScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            k2hSizedBox,
            Text(
              "Upload Memory",
              style: TextStyleConstants.displaySmallWhiteBold(context),
            ),
            k1hSizedBox,
            Text(
              "It is a long established fact that a reader will "
                  "be distracted by the readable content"
                  " of a page when looking at its layout.",
              textAlign: TextAlign.center,
              style: TextStyleConstants.bodyLargeWhite(context),
            ),
            k2hSizedBox,
            CustomGlassmorphicContainer(
                padding: EdgeInsets.symmetric(
                  vertical: 6.h,
                ),
                child: InkWell(
                  onTap: () {
                    controller.pickImageOrVideo();
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 8.h,
                          Icons.image_outlined,
                          color: AppColors.kIconColor,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          "Select Image or Video",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                )),
            Row(
              children: [
                const Expanded(child: Divider()),
                k1wSizedBox,
                const Text("Or"),
                k1wSizedBox,
                const Expanded(child: Divider())
              ],
            ),
            CustomGlassmorphicContainer(
                child: InkWell(
                  onTap: () {
                    controller.takePhotoOrVideo();
                  },
                  child: Center(
                    child: Text(
                      "Take a Photo/Video",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                  ),
                )),
            // GridView to display selected images
            Obx(() {
              if (controller.pickedFiles.isEmpty) {
                return const SizedBox();
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 3.h,
                    crossAxisSpacing: 4.w),
                itemCount: controller.pickedFiles.length,
                itemBuilder: (context, index) {
                  final file = controller.pickedFiles[index];
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            file,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 2.w,
                          top: 2,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  controller.removeFile(file);
                                }),
                          ))
                    ],
                  );
                },
              );
            }),
            SizedBox(
              height: 8.h,
            ),
            Obx(() {
              return controller.pickedFiles.isEmpty
                  ? const SizedBox()
                  : GradientButton(
                  onPressed: () {
                    controller.uploadMedia();
                  },
                  text: "Continue",
                  gradients: const [Colors.purple, Colors.blue]);
            }),
          ],
        ),
      ),
    );
  }
}
