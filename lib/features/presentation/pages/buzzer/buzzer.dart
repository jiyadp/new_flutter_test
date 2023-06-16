import 'dart:async';
import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/features/domain/usecase/buzzer_usecase.dart';
import 'package:eminencetel/features/presentation/bloc/login_cubit.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/utils/buzzer_stream_controller.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:eminencetel/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class BuzzerScreen extends StatefulWidget {
  const BuzzerScreen({Key? key}) : super(key: key);

  static const String id = 'buzzer_screen';

  @override
  State<BuzzerScreen> createState() => _BuzzerScreenState();
}

class _BuzzerScreenState extends State<BuzzerScreen> {

  var buzzerUseCase = getIt<BuzzerUseCase>();
  var user = getIt<LoginCubit>().getUser();

  @override
  void dispose() {
    BuzzerStreamController().initEventStream();
    super.dispose();
  }
  MethodChannel channel = const MethodChannel('callback_channel');

  Future<void> stopServiceFromNativeCode() async {
    try {
      await channel.invokeMethod('stopService');
    } on PlatformException catch (e) {
      logger.d(e.stacktrace);
    }
  }

  Future<void> restartServiceFromNativeCode() async {
    try {
      var schedules = buzzerUseCase.invoke(const NoParams());
      var userId = user.id;
      var email = user.email;
      var employeeId = user.employeeId;
      var taskNo = schedules.task?.taskNo ?? "";
      var siteId = schedules.site?.id ?? "";
      var siteName = schedules.site?.name ?? "";
      var siteAddress = schedules.site?.address ?? "";
      var latitude = schedules.site?.latitude ?? "";
      var longitude = schedules.site?.longitude ?? "";
      var duration = schedules.task?.buzzerDuration ?? 0;
      var interval = schedules.task?.buzzerInterval ?? 0;

      if(duration != 0 && interval != 0) {
        await channel.invokeMethod('restartService', <String, dynamic>{
          "duration": "$duration",
          "interval": "$interval",
          "userId":"$userId",
          "email":"$email",
          "employeeId":"$employeeId",
          "taskNo":taskNo,
          "siteId":siteId,
          "siteName":siteName,
          "siteAddress":siteAddress,
          "latitude":latitude,
          "longitude":longitude
        });
      }
    } on PlatformException catch (e) {
      logger.d(e.stacktrace);
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CustomColors.white,
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
            width: 325,
            height: 325,
            decoration: ShapeDecoration(
                shape: CircleBorder(
                    side: BorderSide(
                        color: CustomColors.red,
                        style: BorderStyle.solid,
                        width: 10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.notifications_active,
                  color: CustomColors.red,
                  size: 32,
                ),
                Text(
                  "Are you safe ?",
                  style: CustomTextStyles.bold30Buzzer(),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: ConfirmationSlider(
              backgroundColor: CustomColors.black,
              onConfirmation: () {
                BuzzerStreamController().isBuzzerScreenAlreadyOpened = false;
                restartServiceFromNativeCode();
                Navigator.of(context).pop();
              },
              height: 80,
              sliderButtonContent: Icon(
                Icons.chevron_right,
                color: CustomColors.white,
                size: 36,
              ),
              textStyle: CustomTextStyles.buzzerSemiBold(),
              text: "I'm safe",
            ),
          ),
        )
      ],
    ));
  }
}
