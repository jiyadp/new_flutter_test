import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:flutter/material.dart';

class OpenFileErrorScreen extends StatelessWidget {
  final String errorMessage;
  const OpenFileErrorScreen({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: CustomColors.red,
                  size: 60,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
