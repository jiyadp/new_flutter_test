import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String hint;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final void Function(String?)? onSave;
  final String? Function(String?)? validator;
  final Function()? onClick;
  final String? errorText;
  final Icon? icon;
  final bool? obscureText;
  final bool readOnly;
  final TextInputType? textInputType;
  String? value;

  CustomTextFieldWidget(
      {Key? key,
      required this.hint,
      this.value,
      this.onChanged,
      this.onSave,
      this.onClick,
      this.icon,
      this.obscureText,
      this.textEditingController,
      this.validator,
      this.textInputType,
      this.readOnly = false,
      this.errorText})
      : super(key: key);

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    widget.textEditingController?.text = widget.value ?? "";
    return SizedBox(
        height: 70,
        child: GestureDetector(
          onPanUpdate: (details) {
            // Swiping in right direction.
            if (details.delta.dx > 0) {
              widget.textEditingController?.text = "N/A";
            }

            // Swiping in left direction.
            if (details.delta.dx < 0) {
              widget.textEditingController?.text = "N/A";
            }
          },
          child: TextFormField(
            readOnly: widget.readOnly,
            controller: widget.textEditingController,
            style: CustomTextStyles.regular14(CustomColors.black),
            expands: false,
            onSaved: widget.onSave,
            onChanged: widget.onChanged,
            onTap: widget.onClick,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.textInputType,
            cursorColor: CustomColors.black,
            obscureText: widget.obscureText ?? false,
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
              labelText: widget.hint,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.red),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.red, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              prefixIcon: widget.icon,
              labelStyle: CustomTextStyles.bold16(CustomColors.hash),
            ),
          ),
        ));
  }
}
