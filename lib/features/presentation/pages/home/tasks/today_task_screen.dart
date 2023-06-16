import 'dart:async';
import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/presentation/bloc/tasks_cubit.dart';
import 'package:eminencetel/features/presentation/pages/task/task_details_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/task_card_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TodayTasksScreen extends StatefulWidget {
  const TodayTasksScreen({Key? key}) : super(key: key);

  @override
  State<TodayTasksScreen> createState() => _TodayTasksScreenState();
}

class _TodayTasksScreenState extends State<TodayTasksScreen> with WidgetsBindingObserver {
  late final List<TasksData> _searchResult = [];
  late List<TasksData>? _myTasksModelList = [];
  TextEditingController controllerText = TextEditingController();
  var taskCubit = getIt<TasksCubit>();

  Future refresh() async {
    _myTasksModelList?.clear();
    _searchResult.clear();
    setState(() {
      taskCubit.getTodaysTasks();
    });
  }

  @override
  Widget build(BuildContext context) {

    taskCubit.syncTasks();
    var unfinishedTasksCount = taskCubit.getUnFinishedTasksCount();

     // = Provider.of<StreamData>(context);
    return BlocProvider<TasksCubit>(
      create: (_) => taskCubit..getTodaysTasks(),
      child: BlocBuilder<TasksCubit, DataState<TasksModel>>(
          builder: (context, state) {
        _myTasksModelList = state.data?.data;
        //_searchResult = state.data?.data;
        return Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: refresh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // StreamBuilder(
                //   stream: MethodChannelTest().initstate(),
                //   builder: (context, snapshot) {
                //     return Container(
                //       child: Text("hello ${snapshot.data}"),
                //     );
                //   },
                // ),
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
                // Center(
                //   child: Consumer<StreamData>(
                //     builder: (a,streamData,c)=> StreamBuilder<int>(
                //         stream: streamDatas.stream,
                //         builder: (context, snapshot) {
                //           if (snapshot.hasData) {
                //             if(snapshot.data == 0) {
                //               // if(!streamData.setBuzzerStatus(true)) {
                //               //   streamData.setBuzzerStatus(true);
                //               //   Future.delayed(const Duration(milliseconds: 50), () {
                //               //     Navigator.pushNamed(context, BuzzerScreen.id);
                //               //   });
                //               // }
                //             }
                //             return Text('Safety Timer is running ${snapshot.data}');
                //           } else {
                //             return Text('Safety Timer is off ${snapshot.error} ${streamData.timer}');
                //           }
                //         }
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: unfinishedTasksCount > 0
                      ? [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/ic_warning.svg',
                                  height: 43.0,
                                  width: 43.0,
                                  cacheColorFilter: true,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    "You have $unfinishedTasksCount work orders with unfinished task assigned.",
                                    style: CustomTextStyles.subheading(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // Padding(
                          //   padding:
                          //   const EdgeInsets.symmetric(horizontal: 16),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       GestureDetector(
                          //         onTap: () {
                          //           Navigator.pushNamed(context, UnfinishedTasksScreen.id);
                          //         },
                          //         child: Text(
                          //           "VIEW UNFINISHED TASKS",
                          //           style: CustomTextStyles.headingBoldBlue(),
                          //           textAlign: TextAlign.end,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]
                      : [],
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Text(
                //     "Today",
                //     style: CustomTextStyles.headingBold(),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
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
                                                        .getTodaysTasks();
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
