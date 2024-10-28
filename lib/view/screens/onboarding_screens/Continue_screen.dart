import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../constants/constants.dart';
import 'Questions_screen.dart';

class ContinueScreen extends StatelessWidget {
  const ContinueScreen({super.key});
  static const routeName = "ContinueScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      padding: const EdgeInsets.all(0),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: FutureBuilder(
              future: Future.delayed(
                  const Duration(milliseconds: 1500)), // Simulate loading time
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show loading animation
                  return const SizedBox();
                } else {
                  // Show another animation after loading
                  return Lottie.asset(
                    LottieAssets.confettie,
                    fit: BoxFit.cover,
                    // frameRate: FrameRate(10),
                    // alignment: Alignment.center,
                    repeat: false,
                    animate: true,
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
            child: Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 500)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading animation
                      return SizedBox(
                        height: 20.h,
                      );
                    } else {
                      return Lottie.asset(
                        LottieAssets.loading,
                        height: 30.h,
                        fit: BoxFit.cover,
                        repeat: false,
                        animate: true,
                      );
                    }
                  },
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
                  " We're excited to share that your picture will"
                  " be the cover of a special collection of cherished memories and videos,"
                  " which will be delivered to your loved ones at a time you choose,"
                  " allowing you to share those precious moments with them.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(
                  height: kButtonHeight,
                  child: GradientButton(
                    onPressed: () {
                      Get.toNamed(QuestionsScreen.routeName);
                    },
                    text: 'Continue',
                    textColor: Colors.lightBlue[900],
                    gradients: const [
                      Colors.blue,
                      Colors.white,
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}