import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class GlassTextFieldWithTitle extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final IconData? icon;
  const GlassTextFieldWithTitle({
    super.key,
    required this.title,
    this.hintText,
    this.controller,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        k1hSizedBox,
        TextField(
          controller: controller,
          decoration:
              InputDecoration(hintText: hintText ?? "", suffixIcon: Icon(icon)),
        ),
      ],
    );
  }
}
