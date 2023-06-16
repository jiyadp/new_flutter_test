import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CustomIconTextField extends StatelessWidget {
  final String hint;
  final Function(String) onChanged;
  final Function() onClick;
  final Icon icon;
  final TextEditingController controller;

  const CustomIconTextField({
    Key? key,
    required this.hint,
    required this.onChanged,
    required this.onClick,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        height: 50,
        child: TextField(
          style: CustomTextStyles.regular14(CustomColors.black),
          controller: controller,
          onChanged: onChanged,
          maxLines: 1,
          expands: false,
          cursorColor: CustomColors.black,
          enabled: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hint,
            labelStyle: CustomTextStyles.bold16(CustomColors.black),
            prefixIcon: icon,
          ),
        ),
      ),
    );
  }
}
