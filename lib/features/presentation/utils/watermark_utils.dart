import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:eminencetel/features/presentation/utils/watermark_library.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class WaterMarkUtils {


  static Future<Uint8List> addWaterMarksLogo(dynamic args) async {

    final originalImageBytes = args['originalImageBytes'] as Uint8List;
    final watermarkImageBytes = args['watermarkImageBytes'] as Uint8List;
    final imgHeight = args['imgHeight'] as int;
    final imgWidth = args['imgWidth'] as int;
    final dstX = args['dstX'] as int;
    final dstY = args['dstY'] as int;

    return await Watermark.addImageWatermark(
        originalImageBytes: originalImageBytes,
        waterkmarkImageBytes: watermarkImageBytes,
        imgHeight: imgHeight,
        imgWidth: imgWidth,
        dstX: dstX,
        dstY: dstY
    );
  }

  static Future<Uint8List> addWaterMarksText(dynamic args) async {

    final originalImageBytes = args['originalImageBytes'] as Uint8List;
    final robotoFont = args['font'] as img.BitmapFont;
    final watermarkText = args['watermarkText'] as String;
    final dstX = args['dstX'] as int;
    final dstY = args['dstY'] as int;
    final color = args['color'] as Color;

    return await Watermark.addTextWatermark(
        imgBytes: originalImageBytes,
        watermarkText: watermarkText,
        font: robotoFont,
        dstX: dstX,
        dstY: dstY);
  }



  static Future<File?> writeImageToFiles(String myImagePath, Uint8List updatedWaterMarkedImage) async {
    File imageFile = File(myImagePath);
    imageFile.create(recursive: true);
    imageFile.writeAsBytes(updatedWaterMarkedImage);
    return imageFile;
  }

}