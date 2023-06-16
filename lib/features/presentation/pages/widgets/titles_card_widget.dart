import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:flutter/material.dart';

class TitlesCardWidget extends StatelessWidget {
  final String title;
  final Function() onClick;

  const TitlesCardWidget({
    Key? key,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: onClick,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.black,
                ),
                color: CustomColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(3))),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: CustomTextStyles.regular14(CustomColors.black),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
