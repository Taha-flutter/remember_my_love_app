import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/colors_constants.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/Upload_memory_controller.dart';
import '../../../../../utills/ConvertDateTime.dart';
import '../../../../widgets/Custom_glass_container.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';
import '../../../../widgets/custom_scaffold.dart';

class ScheduleMemoryScreen extends GetView<UploadMemoryController> {
  const ScheduleMemoryScreen({super.key});
  static const routeName = "ScheduleMemoryScreen";

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
                "Schedule Memory",
                style: TextStyleConstants.headlineLargeWhite(context),
              )
            ],
          ),
          k2hSizedBox,
          CustomGlassmorphicContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Set Delivery Date"),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      controller.buttonVisivility.value = false;
                      BottomPicker.date(
                        displayCloseIcon: true,
                        closeIconColor: AppColors.kPrimaryColor,
                        dismissable: false,
                        displaySubmitButton: true,
                        backgroundColor: AppColors.kGlassColor,
                        pickerTitle: Text(
                          '',
                          style: TextStyleConstants.bodyLargeWhite(context),
                        ),
                        buttonStyle: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        buttonWidth: context.isTablet ? 40.w : 90.w,
                        buttonContent: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.h,
                            ),
                            child: Text(
                              "Save",
                              style: TextStyleConstants.bodyMediumWhite(context)
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ),
                        dateOrder: DatePickerDateOrder.mdy,
                        initialDateTime: controller.selectedDate.value,
                        minDateTime: controller.selectedDate.value
                            .subtract(const Duration(days: 1)),
                        pickerTextStyle: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                        ),
                        onChange: (index) {
                          controller.selectedDate.value = index;
                        },
                        onSubmit: (index) {
                          print(index);
                          // controller.updateSelectedDate(index);
                          controller.buttonVisivility.value = true;
                        },
                        onCloseButtonPressed: () {
                          controller.buttonVisivility.value = true;
                          Get.back();
                        },
                      ).show(context);
                    },
                    child: CustomGlassmorphicContainer(
                        borderRadius: 8,
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              return Text(DateFormat('MM/dd/yyyy')
                                  .format(controller.selectedDate.value));
                            }),
                            const Icon(
                              Icons.event,
                              color: AppColors.kIconColor,
                            )
                          ],
                        )),
                  ),
                ),
                k1hSizedBox,
                const Text("Set Delivery Time"),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      controller.buttonVisivility.value = false;
                      BottomPicker.time(
                        displayCloseIcon: true,
                        closeIconColor: AppColors.kPrimaryColor,
                        dismissable: false,
                        displaySubmitButton: true,
                        backgroundColor: AppColors.kGlassColor,
                        pickerTitle: Text(
                          '',
                          style: TextStyleConstants.bodyLargeWhite(context),
                        ),
                        buttonStyle: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        buttonWidth: context.isTablet ? 40.w : 90.w,
                        buttonContent: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.h,
                            ),
                            child: Text(
                              "Save",
                              style: TextStyleConstants.bodyMediumWhite(context)
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ),
                        initialTime: Time(
                            hours: controller.selectedDate.value.hour,
                            minutes: controller.selectedDate.value.minute),
                        pickerTextStyle: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                        ),
                        onChange: (time) {
                          DateTime currentDate = controller.selectedDate.value;
                          controller.selectedDate.value = DateTime(
                            currentDate.year,
                            currentDate.month,
                            currentDate.day,
                            time.hour,
                            time.minute,
                          );
                          // print(index);
                        },
                        onSubmit: (index) {
                          controller.buttonVisivility.value = true;
                        },
                        onCloseButtonPressed: () {
                          controller.buttonVisivility.value = true;
                          Get.back();
                        },
                      ).show(context);
                    },
                    child: CustomGlassmorphicContainer(
                        borderRadius: 8,
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              return Text(DateFormat('hh:mm a')
                                  .format(controller.selectedDate.value));
                            }),
                            const Icon(
                              Icons.access_time,
                              color: AppColors.kIconColor,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Obx(() {
            return controller.buttonVisivility.value
                ? controller.isloading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GradientButton(
                        onPressed: () {
                          final formateddate =
                              DateFormat("yyyy-MM-ddTHH:mm:ssZ")
                                      .format(controller.selectedDate.value) +
                                  formattedTimeZoneOffset(
                                      controller.selectedDate.value);
                          controller.selectedFormatedDate = formateddate;
                          controller.reschedualMemory.value == null
                              ? controller.createMemory()
                              : controller.updateMemory();
                        },
                        text: "Send",
                        gradients: const [Colors.purple, Colors.blue])
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
