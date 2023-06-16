import 'package:eminencetel/features/data/models/schedules_model.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulesCardWidget extends StatelessWidget {
  final SchedulesData schedulesData;
  final Function() onClick;
  const SchedulesCardWidget(
      {Key? key, required this.schedulesData, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat('dd-MM-yyyy');
    var formattedEndDate =
        formatter.format(DateTime.parse("${schedulesData.endDate}"));
    var formattedStartDate =
        formatter.format(DateTime.parse("${schedulesData.startDate}"));

    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 16, right: 16, top: 5),
      child: GestureDetector(
        onTap: onClick,
        child: Card(
          elevation: 3,
          color: CustomColors.taskcardbackgroundcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${schedulesData.scheduleNo}",
                  style: CustomTextStyles.headingBold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      LocaleStrings.task_card_label_site,
                      style: CustomTextStyles.subheading(),
                    )),
                    Flexible(
                      flex: 3,
                      child: Text(
                        "${schedulesData.site?.name}",
                        style: CustomTextStyles.subheadingBold(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Flexible(
                //         child: Text(
                //       LocaleStrings.task_card_label_scheduledNo,
                //       style: CustomTextStyles.subheading(),
                //     )),
                //     Flexible(
                //       child: Text(
                //         "${taskData.scheduleNo}",
                //         style: CustomTextStyles.subheadingBold(),
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //       flex: 2,
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Row(
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Text(
                            LocaleStrings.task_card_label_startDate,
                            style: CustomTextStyles.subheading(),
                          )),
                          Flexible(
                            child: Text(
                              formattedStartDate,
                              style: CustomTextStyles.subheadingBold(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Text(
                            LocaleStrings.task_card_label_endDate,
                            style: CustomTextStyles.subheading(),
                          )),
                          Flexible(
                            child: Text(
                              formattedEndDate,
                              style: CustomTextStyles.subheadingBold(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                operatorWidgetConditions(context),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      LocaleStrings.task_card_label_post_code,
                      style: CustomTextStyles.subheading(),
                    )),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "${schedulesData.site?.postCode}",
                        style: CustomTextStyles.subheadingBold(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Flexible(
                //         child: Text(
                //       LocaleStrings.task_card_label_scope_of_work,
                //       style: CustomTextStyles.subheading(),
                //     )),
                //     Expanded(
                //       child: Text(
                //         "${schedulesData.task?.scope}",
                //         style: CustomTextStyles.subheadingBold(),
                //         maxLines: 2,
                //         textAlign: TextAlign.start,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //       flex: 2,
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget operatorWidgetConditions(BuildContext contexts) {
    if ("${schedulesData.operator}" == "MBNL-BT/3UK") {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: Text(
                LocaleStrings.schedules_mbnlId,
                style: CustomTextStyles.subheading(),
              )),
              Flexible(
                flex: 2,
                child: Text(
                  "${schedulesData.site?.operatorId}",
                  style: CustomTextStyles.subheadingBold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: Text(
                LocaleStrings.schedules_tmobileId,
                style: CustomTextStyles.subheading(),
              )),
              Flexible(
                flex: 2,
                child: Text(
                  "${schedulesData.site?.tmobileId}",
                  style: CustomTextStyles.subheadingBold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: Text(
                LocaleStrings.schedules_threeUkId,
                style: CustomTextStyles.subheading(),
              )),
              Flexible(
                flex: 2,
                child: Text(
                  "${schedulesData.site?.threeUkId}",
                  style: CustomTextStyles.subheadingBold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: Text(
                LocaleStrings.schedules_vfId,
                style: CustomTextStyles.subheading(),
              )),
              Flexible(
                flex: 2,
                child: Text(
                  "${schedulesData.site?.operatorId}",
                  style: CustomTextStyles.subheadingBold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: Text(
                LocaleStrings.schedules_tefId,
                style: CustomTextStyles.subheading(),
              )),
              Flexible(
                flex: 2,
                child: Text(
                  "${schedulesData.site?.tefId}",
                  style: CustomTextStyles.subheadingBold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: Text(
                LocaleStrings.schedules_ctil,
                style: CustomTextStyles.subheading(),
              )),
              Flexible(
                flex: 2,
                child: Text(
                  "${schedulesData.site?.ctilId}",
                  style: CustomTextStyles.subheadingBold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      );
    }
  }
}
