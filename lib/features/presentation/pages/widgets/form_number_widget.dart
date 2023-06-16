import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:flutter/material.dart';

class FormNumberWidget extends StatelessWidget {
  final String title;
  final Function() onClick;

  const FormNumberWidget({
    Key? key,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: CustomTextStyles.boldCheckList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
