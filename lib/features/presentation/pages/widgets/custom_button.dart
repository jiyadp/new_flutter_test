import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onClick;
  final bool isLoading;
  final Color buttonColor;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.onClick,
      required this.buttonColor,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: ElevatedButton(
              onPressed: isLoading ? null : onClick,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                )),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return buttonColor;
                    }
                    return buttonColor; // Use the component's default.
                  },
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(text,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.bold16(CustomColors.white)),
                  ),
                  isLoading
                      ? const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
