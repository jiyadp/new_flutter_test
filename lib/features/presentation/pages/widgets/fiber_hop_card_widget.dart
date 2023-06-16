import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:flutter/material.dart';

class FiberHopeCardWidget extends StatelessWidget {
  final String projectName;
  final String siteName;
  final String siteId;
  final Function() onClick;

  const FiberHopeCardWidget(
      {Key? key,
      required this.projectName,
      required this.onClick,
      required this.siteId,
      required this.siteName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: onClick,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: CustomColors.cardBack,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Project",
                    style: CustomTextStyles.regular20(),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    projectName,
                    style: CustomTextStyles.bold14(CustomColors.black),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "SiteName",
                    style: CustomTextStyles.regular20(),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    siteName,
                    style: CustomTextStyles.bold14(CustomColors.black),
                    textAlign: TextAlign.start,
                  ),
                ],
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
