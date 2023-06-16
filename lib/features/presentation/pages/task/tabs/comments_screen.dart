import 'dart:math';

import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/data/models/update_task_status_model.dart';
import 'package:eminencetel/features/domain/usecase/update_task_status_usecase.dart';
import 'package:eminencetel/features/presentation/bloc/schedule_details_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/update_task_status_cubit.dart';
import 'package:eminencetel/features/presentation/pages/widgets/comment_textfield_widget.dart';
import 'package:eminencetel/features/presentation/pages/widgets/comment_widget.dart';
import 'package:eminencetel/features/presentation/utils/text_utils.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);
  static const String id = 'comments';

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _random = Random();
  final List msg = MessageType.values;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var schedules = getIt<ScheduleDetailsCubit>().getSchedules();
    final UpdateTaskStatusCubit updateTaskStatusCubit =
        getIt<UpdateTaskStatusCubit>();
    final commentTextController = TextEditingController();
    late List<Comments?>? myTasksModelList = [];
    myTasksModelList = schedules.task?.comments;
    if (myTasksModelList?.isEmpty == false) {
      myTasksModelList?.sort((b, a) => a!.date!.compareTo(b!.date!));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          BlocProvider<UpdateTaskStatusCubit>(
              create: (_) => updateTaskStatusCubit,
              child: BlocListener<UpdateTaskStatusCubit,
                  DataState<UpdateTaskStatusModel>>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    var comments = schedules.task?.comments;
                    var newComment = state.data?.data;
                    comments?.add(Comments(
                        date: newComment?.date,
                        comment: newComment?.comment,
                        user: newComment?.user));
                    schedules.task?.comments = comments;
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
                      const snackBar =
                          SnackBar(content: Text("Comment added successfully"));
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
                  return Form(
                    key: _formKey,
                    child: CommentTextFieldWidget(
                        validator: (comment) {
                          return TextUtils.emptyValidation(comment!);
                        },
                        onChanged: (v) {},
                        onClicked: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState?.validate() == true) {
                            context.read<UpdateTaskStatusCubit>().updateTask(
                                UpdateTaskStatusParams(
                                    scheduleId: schedules.id ?? "",
                                    taskNo: schedules.task?.taskNo ?? "",
                                    comments: commentTextController.text,
                                    taskStatus:
                                        schedules.task?.taskStatus ?? ""));
                          }
                        },
                        controller: commentTextController,
                        hint: "Type your comments..."),
                  );
                }),
              )),
          const SizedBox(height: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: myTasksModelList != null
                ? List.from(
                    myTasksModelList.map(
                      (item) => CommentWidget(
                        comment: "${item?.comment}",
                        email: "${item?.user?.email}",
                        name: "${item?.user?.name}",
                        time: "${item?.date}",
                        messageType: msg[_random.nextInt(2)],
                      ),
                    ),
                  )
                : [],
          ),
        ],
      ),
    );
  }
}
