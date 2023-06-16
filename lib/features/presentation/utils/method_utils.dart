import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

class MethodUtils {
  getFormattedDate(String hour, String minute) {
    var inputFormat = DateFormat('H:m');
    var inputDate = inputFormat.parse('$hour:$minute');
    var outputFormat = DateFormat('HH:mm');
    return outputFormat.format(inputDate);
  }

  Future<Uint8List> getImageByteFromAssets() async {
    final byteData = await rootBundle.load('assets/images/logo.png');
    Uint8List imageUInt8List =  byteData.buffer.asUint8List(byteData.offsetInBytes,byteData.lengthInBytes);
    return imageUInt8List;
  }
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
