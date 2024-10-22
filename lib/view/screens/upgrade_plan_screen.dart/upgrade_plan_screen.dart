import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/Choose_your_plan_controller.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:remember_my_love_app/view/screens/splash_screens/Splah_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UpgradePlanScreen extends StatelessWidget {
  final ChooseYourPlanController planController =
      Get.put(ChooseYourPlanController());
  UpgradePlanScreen({super.key});
  static const routeName = 'UpgradePlanScreen';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Row(
            children: [
              CustomGlassButton(
                padding: EdgeInsets.all(4.w),
                borderRadius: BorderRadius.circular(50),
                child: Icon(
                  size: 3.h,
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
              k3wSizedBox,
              Text("Upgrade Your Plan",
                  style: TextStyleConstants.headlineLargeWhite(context)),
            ],
          ),
          k4hSizedBox,
          Obx(
            () => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.kPrimaryColor, width: 2),
              ),
              height: kButtonHeight, // Ensure this constant is properly defined
              width: 60.w,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        planController.changePlan('Monthly');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: planController.selectedPlan.value == 'Monthly'
                              ? AppColors.kPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(width: 0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Monthly",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: planController.selectedPlan.value ==
                                            'Monthly'
                                        ? AppColors.kSecondaryColor
                                        : AppColors.kTextWhite,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        planController.changePlan('Yearly');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: planController.selectedPlan.value == 'Yearly'
                              ? AppColors.kPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Yearly",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: planController.selectedPlan.value ==
                                            'Yearly'
                                        ? AppColors.kSecondaryColor
                                        : AppColors.kTextWhite,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Obx(() {
            if (planController.selectedPlan.value == 'Monthly') {
              return Column(
                children: [
                  k4hSizedBox,
                  CustomGlassmorphicContainer(
                    width: double.infinity,
                    height: 22.h,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$25",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "/Month",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          k2hSizedBox,
                          Text(
                            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                            textAlign: TextAlign.center,
                            style: TextStyleConstants.bodySmallWhite(context),
                          ),
                          k2hSizedBox,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.kIconColor,
                              ),
                              k1wSizedBox,
                              Text(
                                "Get 100 GB Storage",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const Spacer(),
                  SizedBox(
                    height: 26.h,
                  ),
                  GradientButton(
                      onPressed: () {},
                      text: "Select this Plan",
                      gradients: [Colors.purple, Colors.blue])
                ],
              ); // Added const for optimization
            } else {
              return Column(
                children: [
                  k4hSizedBox,
                  CustomGlassmorphicContainer(
                    width: double.infinity,
                    height: 22.h,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$280",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "/Year",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          k2hSizedBox,
                          Text(
                            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                            textAlign: TextAlign.center,
                            style: TextStyleConstants.bodySmallWhite(context),
                          ),
                          k2hSizedBox,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.kIconColor,
                              ),
                              k1wSizedBox,
                              Text(
                                "Get 1 TB Storage",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const Spacer(),
                  SizedBox(
                    height: 26.h,
                  ),
                  GradientButton(
                      onPressed: () {},
                      text: "Select this Plan",
                      gradients: [Colors.purple, Colors.blue])
                ],
              );
              ; // Added const for optimization
            }
          }),
        ],
      ),
    );
  }
}
