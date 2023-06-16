import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCardWidget extends StatelessWidget {
  final TasksData taskData;
  final Function() onClick;
  const TaskCardWidget(
      {Key? key, required this.taskData, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat('dd-MM-yyyy');
    var formattedEndDate =
        formatter.format(DateTime.parse("${taskData.task?.endDate}"));
    var formattedStartDate =
        formatter.format(DateTime.parse("${taskData.task?.startDate}"));
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
                  "${taskData.task?.taskNo}",
                  style: CustomTextStyles.subtitle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      LocaleStrings.task_card_label_projectName,
                      style: CustomTextStyles.subheading(),
                    )),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "${taskData.project}",
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
                      LocaleStrings.task_card_label_site,
                      style: CustomTextStyles.subheading(),
                    )),
                    Flexible(
                      flex: 3,
                      child: Text(
                        "${taskData.site?.name}",
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
                      LocaleStrings.task_card_label_scheduledNo,
                      style: CustomTextStyles.subheading(),
                    )),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "${taskData.scheduleNo}",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      LocaleStrings.task_card_label_operator,
                      style: CustomTextStyles.subheading(),
                    )),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "${taskData.operator}",
                        style: CustomTextStyles.subheadingBold(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Flexible(
                //         child: Text(
                //       LocaleStrings.task_card_label_siteId,
                //       style: CustomTextStyles.subheading(),
                //     )),
                //     Flexible(
                //       child: Text(
                //         "${taskData.site?.id?.substring(0, 9)}",
                //         style: CustomTextStyles.subheadingBold(),
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //       flex: 2,
                //     ),
                //   ],
                // ),
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
                        "${taskData.site?.postCode}",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      LocaleStrings.task_card_label_scope_of_work,
                      style: CustomTextStyles.subheading(),
                    )),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${taskData.task?.scope}",
                        style: CustomTextStyles.subheadingBold(),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                statusWidgetConditions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statusWidgetConditions(BuildContext contexts) {
    if ("${taskData.task?.taskStatus}" == "In progress") {
      return statusWidget(
          contexts: contexts,
          backgroundColor: CustomColors.inProgressStatusTextColor.withAlpha(26),
          textColor: CustomColors.inProgressStatusTextColor);
    } else if ("${taskData.task?.taskStatus}" == "Waiting Approval") {
      return statusWidget(
          contexts: contexts,
          backgroundColor: CustomColors.waitingStatusTextColor.withAlpha(26),
          textColor: CustomColors.waitingStatusTextColor);
    } else if ("${taskData.task?.taskStatus}" == "Abort") {
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: backgroundColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              "${taskData.task?.taskStatus}",
              style: CustomTextStyles.statusStyle(textColor),
            ),
          ),
        )
      ],
    );
  }
}
