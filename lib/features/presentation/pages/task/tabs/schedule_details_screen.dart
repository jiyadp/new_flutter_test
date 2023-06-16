import 'package:eminencetel/features/presentation/bloc/schedule_details_cubit.dart';
import 'package:eminencetel/features/presentation/pages/widgets/label_text_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/method_utils.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ScheduleDetailsScreen extends StatefulWidget {
  const ScheduleDetailsScreen({Key? key}) : super(key: key);
  static const String id = 'details_screen';

  @override
  State<ScheduleDetailsScreen> createState() => _ScheduleDetailsScreenState();
}

class _ScheduleDetailsScreenState extends State<ScheduleDetailsScreen> {
  Future refresh() async {
    setState(() {
      getIt<ScheduleDetailsCubit>().getSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    var schedules = getIt<ScheduleDetailsCubit>().getSchedules();

    String? projectNoInt = schedules.projectNo;

    int? startHourInt = schedules.task?.startTime?.hour;
    int? startMinuteInt = schedules.task?.startTime?.minute;
    String startTime = "";

    int? endHourInt = schedules.task?.endTime?.hour;
    int? endMinuteInt = schedules.task?.endTime?.minute;
    String endTime = "";
    if (startHourInt != null && startMinuteInt != null) {
      startTime = MethodUtils()
          .getFormattedDate(startHourInt.toString(), startMinuteInt.toString());
    }
    if (endHourInt != null && endMinuteInt != null) {
      endTime = MethodUtils()
          .getFormattedDate(endHourInt.toString(), endMinuteInt.toString());
    }
    String projectNo = "";
    String scheduleStatusStr = schedules.scheduleStatus.toString();
    if (projectNoInt != null) {
      projectNo = projectNoInt.toString();
    }
    var formatter = DateFormat('dd-MM-yyyy');

    var formattedStartDate =
        formatter.format(DateTime.parse("${schedules.task?.startDate}"));
    var formattedEndDate =
        formatter.format(DateTime.parse("${schedules.task?.endDate}"));
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
              padding:
                  const EdgeInsets.only(bottom: 5, left: 16, right: 16, top: 0),
              child: Stack(
                children: [
                  Card(
                      elevation: 3,
                      color: CustomColors.cardBack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      margin: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/images/task_card_bg.svg',
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2.45,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleStrings.siteDetails,
                                  style: CustomTextStyles.bold16(
                                      CustomColors.darkBlue),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // LabelTextWidget(
                                //     title: LocaleStrings.siteId,
                                //     description: schedules.site?.id ?? ""),
                                LabelTextWidget(
                                    title: LocaleStrings.siteName,
                                    description: schedules.site?.name ?? ""),
                                LabelTextWidget(
                                    title: LocaleStrings.siteType,
                                    description: schedules.site?.type ?? ""),
                                LabelTextWidget(
                                    title: LocaleStrings.siteAddress,
                                    description: schedules.site?.address ?? ""),
                                LabelTextWidget(
                                    title: LocaleStrings.postCode,
                                    description:
                                        schedules.site?.postCode ?? ""),
                                LabelTextWidget(
                                    title: LocaleStrings.operatorName,
                                    description: schedules.operator ?? ""),
                                schedules.operator == "MBNL-BT/3UK"
                                    ? Column(
                                        children: [
                                          LabelTextWidget(
                                              title: LocaleStrings.mbnlId,
                                              description:
                                                  schedules.site?.operatorId ??
                                                      ""),
                                          LabelTextWidget(
                                              title: LocaleStrings.tmobileId,
                                              description:
                                                  schedules.site?.tmobileId ??
                                                      ""),
                                          LabelTextWidget(
                                              title: LocaleStrings.threeUkId,
                                              description:
                                                  schedules.site?.threeUkId ??
                                                      ""),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          LabelTextWidget(
                                              title: LocaleStrings.vfId,
                                              description:
                                                  schedules.site?.operatorId ??
                                                      ""),
                                          LabelTextWidget(
                                              title: LocaleStrings.tefId,
                                              description:
                                                  schedules.site?.tefId ?? ""),
                                          LabelTextWidget(
                                              title: LocaleStrings.ctil,
                                              description:
                                                  schedules.site?.ctilId ?? ""),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              )),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 5, left: 16, right: 16, top: 0),
            child: Card(
              elevation: 3,
              color: CustomColors.cardBack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              margin: EdgeInsets.zero,
              child: Stack(children: [
                SvgPicture.asset(
                  'assets/images/task_card_bg.svg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleStrings.taskDetails,
                        style: CustomTextStyles.bold16(CustomColors.darkBlue),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LabelTextWidget(
                          title: LocaleStrings.taskNo,
                          description: schedules.task?.taskNo ?? ""),
                      LabelTextWidget(
                          title: LocaleStrings.startDate,
                          description: formattedStartDate),
                      LabelTextWidget(
                          title: LocaleStrings.startTime,
                          description: startTime),
                      LabelTextWidget(
                          title: LocaleStrings.endDate,
                          description: formattedEndDate),
                      LabelTextWidget(
                          title: LocaleStrings.endTime, description: endTime),
                      LabelTextWidget(
                          title: LocaleStrings.outage,
                          description: schedules.task?.outage?.outage ?? ""),
                      LabelTextWidget(
                          title: LocaleStrings.crq,
                          description: schedules.task?.crq ?? ""),
                      LabelTextWidget(
                        title: LocaleStrings.staffName,
                        description: "${schedules.task?.staffMember?.join("")}",
                      ),
                      LabelTextWidget(
                        title: LocaleStrings.scopeOfWork,
                        description: "${schedules.task?.scope}"
                            .replaceAll("\n", "\n\u2022 ")
                            .trim(),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 5, left: 16, right: 16, top: 0),
            child: Card(
              elevation: 3,
              color: CustomColors.cardBack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              margin: EdgeInsets.zero,
              child: Stack(children: [
                SvgPicture.asset(
                  'assets/images/task_card_bg.svg',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.45,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleStrings.schedulesDetails,
                        style: CustomTextStyles.bold16(CustomColors.darkBlue),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LabelTextWidget(
                          title: LocaleStrings.scheduleNo,
                          description: schedules.scheduledNo ?? ""),
                      LabelTextWidget(
                          title: LocaleStrings.accessRequestApproval,
                          description: schedules.accessRequestApproval ?? ""),
                      LabelTextWidget(
                          title: LocaleStrings.assignToStaffMember,
                          description:
                              "${schedules.task?.staffMember?.join("")}"
                                  .replaceAll("\n", "\n\u2022 ")),
                      LabelTextWidget(
                          title: LocaleStrings.assignToTeam,
                          description: schedules.task?.team ?? ""),
                      LabelTextWidget(
                          title: LocaleStrings.assignToSubcontractor,
                          description: schedules.subContractor ?? ""),
                      LabelTextWidget(
                          title: LocaleStrings.scheduleStatus,
                          description: scheduleStatusStr),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
