import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/Bottom_nav_bar_controller.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Widgets/Custom_glass_calendar_widget.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/assets.dart';
import 'Widgets/Letter_list_tile_widget.dart';
import 'Widgets/My_storage_widget.dart';

class HomeScreen extends GetView<HomeScreenController> {
  HomeScreen({super.key});

  final picturesCount = 20;
  final BottomNavController bottomNavController = Get.find();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Call the function to reload data
        await controller.reload();
      },
      child: SingleChildScrollView(
        child: Column(children: [
          // ElevatedButton(
          //     onPressed: () async {
          //       final Map<String, dynamic> jsonMap =
          //           await jsonDecode(Memoryservices.all_mem().toString());
          //       for (var element in jsonMap['data']['memories']) {
          //         ColoredPrint.red(element);
          //         HomeScreenController.memories
          //             .add(MemoryModel.fromJson(element));
          //       }
          //       ColoredPrint.magenta(HomeScreenController.memories.toString());
          //     },
          //     child: Text("Test memory all")),
          InkWell(
            onTap: () {
              bottomNavController.changeTab(4);
            },
            child: CustomGlassmorphicContainer(
              child: Row(
                children: [
                  ClipOval(
                      child: Image.asset(
                    Image_assets.userImage,
                    height: 10.h,
                    width: 10.h,
                    fit: BoxFit.cover,
                  )),
                  k2wSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyleConstants.bodyMediumWhite(context),
                      ),
                      k1hSizedBox,
                      Obx(() {
                        return Text(
                          controller.user.value?.name ?? "------ -------",
                          style: TextStyleConstants.displayMediumWhiteBold(
                              context),
                        );
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
          const My_storage_widget(),
          CustomGlassCalendarWidget(),
          // YearMonthDropdown(),
          Obx(() {
            return controller.isloading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.memories.length,
                    itemBuilder: (context, index) {
                      return LetterListTile(
                        memory: controller.memories[index],
                        files: controller.memories[index].files ?? [],
                        description: controller.memories[index].description,
                        picturesCount: picturesCount,
                        catagory: controller.memories[index].category,
                        creator: controller.memories[index].creator,
                        title: controller.memories[index].title,
                      );
                    });
          })
        ]),
      ),
    );
  }
}
