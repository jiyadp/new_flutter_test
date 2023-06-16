import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle headingBold() {
    return TextStyle(
      fontSize: 16,
      color: CustomColors.subtitlecolor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headingBoldBlue() {
    return TextStyle(
      fontSize: 16,
      color: CustomColors.blueColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle heading() {
    return TextStyle(
      fontSize: 16,
      color: CustomColors.black,
    );
  }

  static TextStyle subtitle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: CustomColors.subtitlecolor,
    );
  }

  static TextStyle subheading() {
    return TextStyle(
      fontSize: 14,
      color: CustomColors.subHeadingColor,
    );
  }

  static TextStyle subheadingBold() {
    return TextStyle(
      fontSize: 14,
      color: CustomColors.black,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle subheadingSemiBold() {
    return TextStyle(
      fontSize: 14,
      color: CustomColors.black,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle buzzerSemiBold() {
    return TextStyle(
      fontSize: 24,
      color: CustomColors.white,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle statusStyle(Color textColor) {
    return TextStyle(
      fontSize: 14,
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle descriptionStyle(Color textColor) {
    return TextStyle(fontSize: 14, color: textColor, height: 1.8);
  }

  static TextStyle bold30() {
    return TextStyle(
      fontSize: 30,
      color: CustomColors.black,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bold30Buzzer() {
    return TextStyle(
      fontSize: 30,
      color: CustomColors.red,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bold40() {
    return TextStyle(
      fontSize: 40,
      color: CustomColors.black,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle regular14(Color textColor) {
    return TextStyle(
      fontSize: 14,
      color: textColor,
    );
  }

  static TextStyle regular16(Color textColor) {
    return TextStyle(
      fontSize: 16,
      color: textColor,
    );
  }

  static TextStyle regular20() {
    return TextStyle(
      fontSize: 20,
      color: CustomColors.black,
    );
  }

  static TextStyle regular12() {
    return TextStyle(
      fontSize: 12,
      color: CustomColors.black,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle boldCheckList() {
    return TextStyle(
      fontSize: 16,
      fontFamily: "Montserrat",
      color: CustomColors.black,
      package: "Montserrat-Regular",
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle smallHeading() {
    return TextStyle(
      fontSize: 12,
      color: CustomColors.hash,
    );
  }

  static TextStyle bold14(Color textColor) {
    return TextStyle(
      fontSize: 14,
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle tabTextStyle() {
    return TextStyle(
      fontSize: 14,
      color: CustomColors.white,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bold16(Color textColor) {
    return TextStyle(
      fontSize: 16,
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bold18() {
    return TextStyle(
      fontSize: 18,
      letterSpacing: 5,
      color: CustomColors.black,
      fontWeight: FontWeight.bold,
    );
  }
}
