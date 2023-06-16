import 'package:eminencetel/features/presentation/pages/buzzer/buzzer.dart';
import 'package:eminencetel/main.dart';
import 'package:flutter/services.dart';

class BuzzerStreamController {
  bool isBuzzerScreenAlreadyOpened = false;

  void initEventStream() {
    var eventChannel = const EventChannel('my_event_channel');
    isBuzzerScreenAlreadyOpened = false;
    eventChannel.receiveBroadcastStream().listen((event) {
      var timer = int.parse(event);
      if(timer == 0 && !isBuzzerScreenAlreadyOpened) {
        isBuzzerScreenAlreadyOpened = true;
        navigatorKey.currentState!.pushNamed(BuzzerScreen.id);
      }
    });
  }
}