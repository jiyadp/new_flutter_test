import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/presentation/bloc/tasks_cubit.dart';
import 'package:eminencetel/features/presentation/pages/task/task_details_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/task_card_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  late final List<TasksData> _searchResult = [];
  late List<TasksData>? _myTasksModelList = [];
  TextEditingController controllerText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksCubit>(
      create: (_) => getIt<TasksCubit>()..getTasks(),
      child: BlocBuilder<TasksCubit, DataState<TasksModel>>(
          builder: (context, state) {
        _myTasksModelList = state.data?.data;
        //_searchResult = state.data?.data;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomIconTextField(
              //   hint: LocaleStrings.title_search,
              //   onChanged: onSearchTextChanged,
              //   onClick: () {},
              //   controller: controllerText,
              //   icon: Icon(
              //     Icons.search,
              //     color: CustomColors.black,
              //     size: 20,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              const SizedBox(
                height: 20,
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
                                    ? List.from(
                                        _searchResult.map(
                                          (item) => TaskCardWidget(
                                            taskData: item,
                                            onClick: () {
                                              Navigator.pushNamed(
                                                  context, TaskDetailsScreen.id,
                                                  arguments: TaskDataModel(
                                                      scheduleId: "${item.id}",
                                                      taskNo:
                                                          "${item.task?.taskNo}"));
                                            },
                                          ),
                                        ),
                                      )
                                    : List.from(
                                        _myTasksModelList!.map(
                                          (item) => item.task?.taskStatus ==
                                                  "Canceled"
                                              ? TaskCardWidget(
                                                  taskData: item,
                                                  onClick: () {
                                                    Navigator.pushNamed(context,
                                                        TaskDetailsScreen.id,
                                                        arguments: TaskDataModel(
                                                            scheduleId:
                                                                "${item.id}",
                                                            taskNo:
                                                                "${item.task?.taskNo}"));
                                                  })
                                              : const SizedBox(),
                                        ),
                                      ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var swcDetails in _myTasksModelList!) {
      if (swcDetails.project
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase())) {
        _searchResult.add(swcDetails);
      }
    }
    setState(() {});
  }
}
