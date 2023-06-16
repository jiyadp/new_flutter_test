import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:flutter/material.dart';

class LabelTextWidget extends StatelessWidget {
  final String title;
  final String description;

  const LabelTextWidget(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: CustomTextStyles.regular14(CustomColors.black),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 2,
            child: Text(
              description,
              style: CustomTextStyles.subheadingSemiBold(),
            ),
          ),
        ],
      ),
    );
  }
}
