import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/constants.dart';
import '../../../../widgets/Custom_glass_container.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';
import '../../../../widgets/custom_scaffold.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});
  static const routeName = "TermsAndConditionScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRoundedGlassButton(
              icon: Icons.arrow_back_ios_new_rounded,
              ontap: () => Get.back(),
            ),
            CustomGlassmorphicContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Terms And Condition",
                  style: TextStyleConstants.displayMediumWhiteBold(context),
                ),
                k1hSizedBox,
                const Text(
                  "Lorem ipsum odor amet, consectetuer adipiscing elit. Mattis morbi nulla himenaeos purus;"
                  "lectus vulputate dolor"
                  "penatibus. Aenean nisi quisque dolor"
                  "donec, ultrices lectus vehicula. At consectetur dui congue ullamcorper vel convallis conubia"
                  "natoque malesuada. Praesent at netus, sed nullam ornare hac. Faucibus tincidunt vulputate hac;"
                  "luctus molestie taciti. Porttitor varius massa gravida quisque semper in in. Nunc"
                  "odio primis magna iaculis facilisis lacinia facilisis."
                  "Tincidunt sodales commodo curabitur mollis mollis ipsum bibendum ligula conubia."
                  "Non nulla massa morbi id nam litora hac sit mattis.",
                  textAlign: TextAlign.center,
                ),
                k1hSizedBox,
                const Text(
                  "Lorem ipsum odor amet, consectetuer adipiscing elit. Mattis morbi nulla himenaeos purus;"
                  "lectus vulputate dolor"
                  "penatibus. Aenean nisi quisque dolor"
                  "donec, ultrices lectus vehicula. At consectetur dui congue ullamcorper vel convallis conubia"
                  "natoque malesuada. Praesent at netus, sed nullam ornare hac. Faucibus tincidunt vulputate hac;"
                  "luctus molestie taciti. Porttitor varius massa gravida quisque semper in in. Nunc"
                  "odio primis magna iaculis facilisis lacinia facilisis."
                  "Tincidunt sodales commodo curabitur mollis mollis ipsum bibendum ligula conubia."
                  "Non nulla massa morbi id nam litora hac sit mattis.",
                  textAlign: TextAlign.center,
                ),
                k1hSizedBox,
                const Text(
                  "Lorem ipsum odor amet, consectetuer adipiscing elit. Mattis morbi nulla himenaeos purus;"
                  "lectus vulputate dolor"
                  "penatibus. Aenean nisi quisque dolor"
                  "donec, ultrices lectus vehicula. At consectetur dui congue ullamcorper vel convallis conubia"
                  "natoque malesuada. Praesent at netus, sed nullam ornare hac. Faucibus tincidunt vulputate hac;"
                  "luctus molestie taciti. Porttitor varius massa gravida quisque semper in in. Nunc"
                  "odio primis magna iaculis facilisis lacinia facilisis."
                  "Tincidunt sodales commodo curabitur mollis mollis ipsum bibendum ligula conubia."
                  "Non nulla massa morbi id nam litora hac sit mattis.",
                  textAlign: TextAlign.center,
                ),
                k1hSizedBox,
                const Text(
                  "Lorem ipsum odor amet, consectetuer adipiscing elit. Mattis morbi nulla himenaeos purus;"
                  "lectus vulputate dolor"
                  "penatibus. Aenean nisi quisque dolor"
                  "donec, ultrices lectus vehicula. At consectetur dui congue ullamcorper vel convallis conubia"
                  "natoque malesuada. Praesent at netus, sed nullam ornare hac. Faucibus tincidunt vulputate hac;"
                  "luctus molestie taciti. Porttitor varius massa gravida quisque semper in in. Nunc"
                  "odio primis magna iaculis facilisis lacinia facilisis."
                  "Tincidunt sodales commodo curabitur mollis mollis ipsum bibendum ligula conubia."
                  "Non nulla massa morbi id nam litora hac sit mattis.",
                  textAlign: TextAlign.center,
                ),
                k1hSizedBox,
              ],
            )),
          ],
        ),
      ),
    );
  }
}
