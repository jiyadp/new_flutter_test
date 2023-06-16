import 'dart:async';
import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/data/models/update_task_status_model.dart';
import 'package:eminencetel/features/domain/usecase/update_task_status_usecase.dart';
import 'package:eminencetel/features/presentation/bloc/login_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/schedule_details_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/tasks_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/update_task_status_cubit.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_button.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/buzzer_stream_controller.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:eminencetel/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class OverviewScreen extends StatefulWidget {
  final BuildContext tabContext;
  final String taskId;
  const OverviewScreen(
      {Key? key, required this.tabContext, required this.taskId})
      : super(key: key);
  static const String id = 'overview_screen';

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen>
    with WidgetsBindingObserver {
  final UpdateTaskStatusCubit updateTaskStatusCubit =
      getIt<UpdateTaskStatusCubit>();
  final Completer<GoogleMapController> _controller = Completer();
  var schedulesCubit = getIt<ScheduleDetailsCubit>();
  var schedules = getIt<ScheduleDetailsCubit>().getSchedules();
  var taskCubit = getIt<TasksCubit>();
  var user = getIt<LoginCubit>().getUser();

  List<Marker> allMarkers = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    String? latitudeStr = schedules.site?.latitude;
    String? longitudeStr = schedules.site?.longitude;
    double? latitude = 0.0;
    double? longitude = 0.0;
    if (latitudeStr != null &&
        longitudeStr != null &&
        latitudeStr != "" &&
        longitudeStr != "" &&
        latitudeStr != "null" &&
        longitudeStr != "null") {
      latitude = double.parse(latitudeStr);
      longitude = double.parse(longitudeStr);
    }

    if (allMarkers.isEmpty) {
      allMarkers.add(Marker(
          markerId: const MarkerId("postion_marker"),
          draggable: false,
          onTap: () {
            MapsLauncher.launchCoordinates(latitude ?? 0, longitude ?? 0);
          },
          position: LatLng(latitude, longitude)));
    }
  }

  @override
  void dispose() {
    // streamSubscription.cancel();
    // streamController.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? latitudeStr = schedules.site?.latitude;
    String? longitudeStr = schedules.site?.longitude;
    double? latitude = 0.0;
    double? longitude = 0.0;
    if (latitudeStr != null &&
        longitudeStr != null &&
        latitudeStr != "" &&
        longitudeStr != "" &&
        latitudeStr != "null" &&
        longitudeStr != "null") {
      latitude = double.parse(latitudeStr);
      longitude = double.parse(longitudeStr);
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.width / 2.7,
              child: GoogleMap(
                onTap: (l) {
                  MapsLauncher.launchCoordinates(latitude ?? 0, longitude ?? 0);
                },
                markers: Set.from(allMarkers),
                mapType: MapType.satellite,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 18.151926040649414,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              LocaleStrings.overview_label_projectName,
              style: CustomTextStyles.regular14(CustomColors.hash),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              schedules.project?.name ?? "",
              style: CustomTextStyles.bold16(CustomColors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              LocaleStrings.overview_label_scheduledNo,
              style: CustomTextStyles.regular14(CustomColors.hash),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              schedules.scheduledNo ?? "",
              style: CustomTextStyles.bold16(CustomColors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              LocaleStrings.overview_label_scopeOfWork,
              style: CustomTextStyles.regular14(CustomColors.hash),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              " ${schedules.task?.scope}".replaceAll("\n", "\n\u2022 "),
              style: CustomTextStyles.bold16(CustomColors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              LocaleStrings.overview_label_status,
              style: CustomTextStyles.regular14(CustomColors.hash),
            ),
            const SizedBox(
              height: 5,
            ),
            statusWidgetConditions(context),
            const SizedBox(
              height: 20,
            ),
            BlocProvider<UpdateTaskStatusCubit>(
                create: (_) => updateTaskStatusCubit,
                child: BlocListener<UpdateTaskStatusCubit,
                    DataState<UpdateTaskStatusModel>>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      // Check for comments
                      var date = state.data?.data?.date;
                      var comment = state.data?.data?.comment;
                      var user = state.data?.data?.user;
                      if (comment?.isNotEmpty == true) {
                        var comments = schedules.task?.comments;
                        comments?.add(
                            Comments(date: date, comment: comment, user: user));
                        schedules.task?.comments = comments;
                      }
                      schedules.task?.taskStatus = state.data?.data?.taskStatus;
                      updateTaskStatusCubit.updateSchedules(schedules);
                      setState(() {});
                    }
                  },
                  child: BlocBuilder<UpdateTaskStatusCubit,
                          DataState<UpdateTaskStatusModel>>(
                      builder: (context, state) {
                    if (state.isSuccess) {
                      //   schedules.task?.taskStatus = state.data?.data?.taskStatus;
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        taskCubit.syncTasks();
                        const snackBar = SnackBar(
                            content: Text("Status updated successfully"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                    if (state.data?.message == "No Schedules found") {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        const snackBar =
                            SnackBar(content: Text("No Schedules found"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                    return Column(
                      children: [
                        state.isInProgress
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : state.data?.message == "No Schedules  found"
                                ? const SizedBox()
                                : statusButtonChanger(context),
                        const SizedBox(
                          height: 20,
                        ),
                        state.data?.message == "No Schedules  found"
                            ? const SizedBox()
                            : cancelButtonChanger(context),
                      ],
                    );
                  }),
                )),
          ],
        ),
      ),
    );
  }

  Widget cancelButtonChanger(BuildContext contexts) {
    if (schedules.task?.taskStatus == "Canceled") {
      return const SizedBox();
    } else if (schedules.task?.taskStatus == "Completed") {
      return const SizedBox();
    } else if (schedules.task?.taskStatus == "Waiting Approval") {
      return CustomButton(
          text: "Cancel",
          onClick: () {
            showBottomSheet(contexts, "Waiting for Cancel");
          },
          buttonColor: CustomColors.primaryAlpha40);
    } else if (schedules.task?.taskStatus == "Waiting for Cancel") {
      return const SizedBox();
    } else if (schedules.task?.taskStatus == "In progress") {
      return CustomButton(
          text: "Cancel",
          onClick: () {
            showBottomSheet(contexts, "Waiting for Cancel");
          },
          buttonColor: CustomColors.primaryAlpha40);
    } else if (schedules.task?.taskStatus == "Scheduled") {
      return CustomButton(
          text: "Cancel",
          onClick: () {
            showBottomSheet(contexts, "Waiting for Cancel");
          },
          buttonColor: CustomColors.primaryAlpha40);
    } else {
      return CustomButton(
          text: "Cancel",
          onClick: () {
            showBottomSheet(contexts, "Waiting for Cancel");
          },
          buttonColor: CustomColors.primaryAlpha40);
    }
  }

  Widget statusButtonChanger(BuildContext contexts) {
    const MethodChannel channel = MethodChannel('callback_channel');
    Future<void> startServiceFromNativeCode() async {
      try {
        var duration = schedules.task?.buzzerDuration ?? 0;
        var interval = schedules.task?.buzzerInterval ?? 0;
        var userId = user.id;
        var email = user.email;
        var employeeId = user.employeeId;
        var taskNo = schedules.task?.taskNo ?? "";
        var siteId = schedules.site?.id ?? "";
        var siteName = schedules.site?.name ?? "";
        var siteAddress = schedules.site?.address ?? "";
        var latitude = schedules.site?.latitude ?? "";
        var longitude = schedules.site?.longitude ?? "";
        if (duration != 0 && interval != 0) {
          schedulesCubit.setTaskDetails(schedules);

          await channel.invokeMethod('startService', <String, dynamic>{
            "duration": "$duration",
            "interval": "$interval",
            "userId": "$userId",
            "email": "$email",
            "employeeId": "$employeeId",
            "taskNo": taskNo,
            "siteId": siteId,
            "siteName": siteName,
            "siteAddress": siteAddress,
            "latitude": latitude,
            "longitude": longitude
          }).then((value) => BuzzerStreamController().initEventStream());
        }
      } on PlatformException catch (e) {
        logger.d(e.stacktrace);
      }
    }

    Future<void> stopServiceFromNativeCode() async {
      try {
        await channel.invokeMethod('stopService');
      } on PlatformException catch (e) {
        logger.d(e.stacktrace);
      }
    }

    if (schedules.task?.taskStatus == "Scheduled") {
      return CustomButton(
          text: "Start",
          onClick: () {
            startServiceFromNativeCode();
            contexts.read<UpdateTaskStatusCubit>().updateTask(
                UpdateTaskStatusParams(
                    scheduleId: schedules.id ?? "",
                    taskNo: schedules.task?.taskNo ?? "",
                    comments: "",
                    taskStatus: "In progress"));
          },
          buttonColor: CustomColors.primary);
    } else if (schedules.task?.taskStatus == "In progress") {
      return CustomButton(
          text: "Send for Approval",
          onClick: () {
            stopServiceFromNativeCode();
            showBottomSheet(contexts, "Waiting Approval");
          },
          buttonColor: CustomColors.primary);
    } else if (schedules.task?.taskStatus == "Waiting Approval") {
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  void showBottomSheet(BuildContext context, String taskStatus) {
    final commentsController = TextEditingController();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext ctx) {
        return Scaffold(
          // use CupertinoPageScaffold for iOS
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true, // important
          body: SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        style: CustomTextStyles.regular14(CustomColors.black),
                        controller: commentsController,
                        autofocus: true,
                        maxLines: 1,
                        expands: false,
                        cursorColor: CustomColors.black,
                        enabled: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
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
                          hintText: "Enter your comments here",
                          labelStyle:
                              CustomTextStyles.bold16(CustomColors.black),
                          prefixIcon:
                              Icon(Icons.message, color: CustomColors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          text: "Comment",
                          onClick: () {
                            //
                            Navigator.of(widget.tabContext).pop();
                            //
                            context.read<UpdateTaskStatusCubit>().updateTask(
                                UpdateTaskStatusParams(
                                    scheduleId: schedules.id ?? "",
                                    taskNo: schedules.task?.taskNo ?? "",
                                    comments: commentsController.text,
                                    taskStatus: taskStatus));
                          },
                          buttonColor: CustomColors.primary),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget statusWidgetConditions(BuildContext contexts) {
    if ("${schedules.task?.taskStatus}" == "In progress") {
      return statusWidget(
          contexts: contexts,
          backgroundColor: CustomColors.inProgressStatusTextColor.withAlpha(26),
          textColor: CustomColors.inProgressStatusTextColor);
    } else if ("${schedules.task?.taskStatus}" == "Waiting Approval") {
      return statusWidget(
          contexts: contexts,
          backgroundColor: CustomColors.waitingStatusTextColor.withAlpha(26),
          textColor: CustomColors.waitingStatusTextColor);
    } else if ("${schedules.task?.taskStatus}" == "Abort") {
      return statusWidget(
          contexts: contexts,
          backgroundColor: CustomColors.abortTextColor.withAlpha(26),
          textColor: CustomColors.abortTextColor);
    } else {
      return statusWidget(
          contexts: contexts,
          backgroundColor: CustomColors.startedStatusTextColor.withAlpha(26),
          textColor: CustomColors.startedStatusTextColor);
    }
  }

  Widget statusWidget(
      {required BuildContext contexts,
      required Color backgroundColor,
      required Color textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: backgroundColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              "${schedules.task?.taskStatus}",
              style: CustomTextStyles.statusStyle(textColor),
            ),
          ),
        )
      ],
    );
  }
}
