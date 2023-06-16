import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/presentation/bloc/tasks_cubit.dart';
import 'package:eminencetel/features/presentation/pages/task/task_details_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/task_card_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/utils/schedule_arg.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulesTaskScreen extends StatefulWidget {
  const SchedulesTaskScreen({Key? key}) : super(key: key);
  static const String id = 'schedule_task_screen';

  @override
  State<SchedulesTaskScreen> createState() => _SchedulesTaskScreenState();
}

class _SchedulesTaskScreenState extends State<SchedulesTaskScreen> {
  late ScheduleArg argumentsModel;

  late final List<TasksData> _searchResult = [];
  late List<TasksData>? _myTasksModelList = [];
  TextEditingController controllerText = TextEditingController();
  var taskCubit = getIt<TasksCubit>();
  Future refresh() async {
    _myTasksModelList?.clear();
    _searchResult.clear();
    setState(() {
      taskCubit.getTasksForSchedules("${argumentsModel.scheduleId}");
    });
  }

  @override
  Widget build(BuildContext context) {
    argumentsModel = ModalRoute.of(context)!.settings.arguments as ScheduleArg;

    return BlocProvider<TasksCubit>(
      create: (_) => taskCubit..getTasksForSchedules("${argumentsModel.scheduleId}"),
      child: BlocBuilder<TasksCubit, DataState<TasksModel>>(
          builder: (context, state) {
            _myTasksModelList = state.data?.data;
            //_searchResult = state.data?.data;
            return Scaffold(
              appBar: AppBar(
                title: Text("Task for ${argumentsModel.title}"),
                leading: IconButton(
                  icon:
                  const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: CustomColors.primary,
              ),
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                onRefresh: refresh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          state.isInProgress
                              ? LinearProgressIndicator(
                            color: CustomColors.black,
                            backgroundColor: CustomColors.white,
                          )
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: state.isEmpty
                                ? [
                              const Center(
                                child: Text("No results found"),
                              )
                            ]
                                : _searchResult.isNotEmpty ||
                                controllerText.text.isNotEmpty
                                ? List.from(_searchResult.map((item) =>
                                TaskCardWidget(
                                  taskData: item,
                                  onClick: () {
                                    Navigator.pushNamed(
                                        context, TaskDetailsScreen.id,
                                        arguments: TaskDataModel(
                                            scheduleId: "${item.id}",
                                            taskNo:
                                            "${item.task?.taskNo}"));
                                  },
                                )))
                                : List.from(
                              _myTasksModelList!.map(
                                    (item) => TaskCardWidget(
                                    taskData: item,
                                    onClick: () {
                                      Navigator.pushNamed(
                                        context,
                                        TaskDetailsScreen.id,
                                        arguments: TaskDataModel(
                                            scheduleId:
                                            "${item.id}",
                                            taskNo:
                                            "${item.task?.taskNo}"),
                                      ).then((_) {
                                        // This block runs when you have returned back to the 1st Page from 2nd.
                                        context
                                            .read<TasksCubit>()
                                            .getTasksForSchedules("${argumentsModel.scheduleId}");
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
