import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/login_model.dart';
import 'package:eminencetel/features/presentation/bloc/login_cubit.dart';
import 'package:eminencetel/features/presentation/pages/home/navigation_drawer_screen.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/utils/buzzer_stream_controller.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String id = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    BuzzerStreamController().initEventStream();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var loginCubit = getIt<LoginCubit>();
    return BlocProvider<LoginCubit>(
        create: (_) => loginCubit..isUserAlreadyLoggedIn(),
        child: BlocBuilder<LoginCubit, DataState<LoginModel>>(
          builder: (context, state) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Future.delayed(const Duration(milliseconds: 3000), () {
                if (state.isSuccess) {
                  Navigator.popAndPushNamed(context, NavigationDrawerScreen.id);
                } else {
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                }
              });
            });
            String version = "";
            String buildNumber = "";
            var asStream = PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
              version = packageInfo.version;
              buildNumber = packageInfo.buildNumber;
            }).asStream();

            return Scaffold(
              backgroundColor: CustomColors.white,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/logo.png',
                                  fit: BoxFit.fill),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: StreamBuilder(
                              stream: asStream,
                              builder: (context, snapshot) {
                                return Text(
                                  "$version : $buildNumber",
                                  style: CustomTextStyles.bold16(
                                      CustomColors.black),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
