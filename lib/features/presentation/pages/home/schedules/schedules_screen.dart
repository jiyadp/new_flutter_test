import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/schedules_model.dart';
import 'package:eminencetel/features/presentation/bloc/schedules_cubit.dart';
import 'package:eminencetel/features/presentation/pages/schedules/schedule_tasks_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/schedules_card_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/utils/schedule_arg.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({Key? key}) : super(key: key);
  static const String id = 'schedules_screen';
  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  late final List<SchedulesData> _searchResult = [];
  late List<SchedulesData>? _mySchedulesModelList = [];
  TextEditingController controllerText = TextEditingController();
  var schedulesCubit = getIt<SchedulesCubit>();

  Future refresh() async {
    _mySchedulesModelList?.clear();
    _searchResult.clear();
    setState(() {
      schedulesCubit.getSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    schedulesCubit.syncTasks();
    return BlocProvider<SchedulesCubit>(
      create: (_) => schedulesCubit..getSchedules(),
      child: BlocBuilder<SchedulesCubit, DataState<SchedulesModel>>(
          builder: (context, state) {
        _mySchedulesModelList = state.data?.data;
        //_searchResult = state.data?.data;
        return Scaffold(
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
                                          SchedulesCardWidget(
                                            schedulesData: item,
                                            onClick: () {
                                              Navigator.pushNamed(
                                                  context, SchedulesTaskScreen.id,
                                                  arguments: ScheduleArg(scheduleId: item.id,title: item.scheduleNo));
                                            },
                                          )))
                                      : List.from(
                                          _mySchedulesModelList!.map(
                                            (item) => SchedulesCardWidget(
                                                 schedulesData: item,
                                                onClick: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    SchedulesTaskScreen.id,
                                                    arguments: ScheduleArg(scheduleId: item.id,title: item.scheduleNo),
                                                  ).then((_) {
                                                    // This block runs when you have returned back to the 1st Page from 2nd.
                                                    context
                                                        .read<SchedulesCubit>()
                                                        .getSchedules();
                                                    //    context.read<TasksCubit>().getTodaysTasks();
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

    for (var schedules in _mySchedulesModelList!) {
      if (schedules.scheduleNo
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase())) {
        _searchResult.add(schedules);
      }
    }
    setState(() {});
  }
}
