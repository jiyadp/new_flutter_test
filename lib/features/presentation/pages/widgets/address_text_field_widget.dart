import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:flutter/material.dart';

class AddressTextFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController? textEditingController;
  final Function(String) onChanged;
  final Function() onClick;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final String? value;

  const AddressTextFieldWidget(
      {Key? key,
      required this.hint,
      this.value,
      this.textEditingController,
      this.textInputType,
      required this.onChanged,
      required this.validator,
      this.readOnly = false,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textEditingController?.text = value ?? "";
    return SizedBox(
      height: 80,
      child: GestureDetector(
          onPanUpdate: (details) {
            // Swiping in right direction.
            if (details.delta.dx > 0) {
              textEditingController?.text = "N/A";
            }

            // Swiping in left direction.
            if (details.delta.dx < 0) {
              textEditingController?.text = "N/A";
            }
          },
          child: TextFormField(
            style: CustomTextStyles.regular14(CustomColors.black),
            onChanged: onChanged,
            readOnly: readOnly,
            keyboardType: textInputType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: textEditingController,
            onTap: onClick,
            validator: validator,
            expands: false,
            maxLines: 7,
            cursorColor: CustomColors.black,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.hash),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.hash),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.black, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: hint,
              labelStyle: CustomTextStyles.bold16(CustomColors.hash),
            ),
          )),
    );
  }
}
