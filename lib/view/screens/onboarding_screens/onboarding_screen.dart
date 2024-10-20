import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/Choose_your_plan_screens/Choose_Your_plan_Screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/Onboarding_controller.dart';
import '../auth_screens/sign_up_screen.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});
  static const routeName = "OnboardingScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            height: 20.h,
            width: 20.h,
            child: Lottie.asset(
              'assets/Lottie/loading.lottie',
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Welcome aboard!",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          k1hSizedBox,
          Text(
            "We're grateful you've joined our community and taken the first step in preserving your family legacy.",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18.sp,
                ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          SizedBox(
            height: kButtonHeight,
            child: GradientButton(
              onPressed: () {
                Get.toNamed(ChooseYourPlanScreen.routeName);
              },
              text: 'Continue',
              textColor: Colors.lightBlue[900],
              gradients: [
                Colors.blue,
                Colors.white,
              ],
            ),
          )
        ],
      ),
    );
  }
}
