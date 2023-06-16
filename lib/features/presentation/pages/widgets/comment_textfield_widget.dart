import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CommentTextFieldWidget extends StatelessWidget {
  final Function(String value) onChanged;
  final Function() onClicked;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CommentTextFieldWidget(
      {Key? key,
      required this.onChanged,
      required this.onClicked,
      required this.controller,
      required this.validator,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: CustomTextStyles.regular14(CustomColors.black),
      textAlignVertical: TextAlignVertical.center,
      expands: false,
      minLines: 1,
      maxLines: 4,
      textAlign: TextAlign.start,
      controller: controller,
      validator: validator,
      cursorColor: CustomColors.black,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: CustomColors.white,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.black),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.black),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.black),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hint,
        labelStyle: CustomTextStyles.regular14(CustomColors.black),
        suffixIcon: GestureDetector(
          onTap: onClicked,
          child: Icon(
            Icons.send,
            color: CustomColors.hash,
          ),
        ),
      ),
    );
  }
}
