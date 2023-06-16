import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/checklist_model.dart';
import 'package:eminencetel/features/domain/usecase/checklist_usecase.dart';
import 'package:eminencetel/features/presentation/bloc/checklist_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/schedule_details_cubit.dart';
import 'package:eminencetel/features/presentation/pages/forms/dynamic_form_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/form_number_widget.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/utils/form_number_argument.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChecklistScreen extends StatefulWidget {
  static const String id = 'checklist';
  final BuildContext tabContext;
  const ChecklistScreen({Key? key, required this.tabContext}) : super(key: key);
  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  late final List<ChecklistData> _searchResult = [];
  late List<ChecklistData>? _myChecklistModelList = [];
  TextEditingController controllerText = TextEditingController();
  final ChecklistCubit checklistCubit = getIt<ChecklistCubit>();
  var schedules = getIt<ScheduleDetailsCubit>().getSchedules();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChecklistCubit>(
      create: (_) => checklistCubit
        ..getChecklist(
            params: ChecklistParams(formNo: "", scheduleId: schedules.id)),
      child: BlocBuilder<ChecklistCubit, DataState<ChecklistModel>>(
          builder: (context, state) {
        _myChecklistModelList = state.data?.data;
        //_searchResult = state.data?.data;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                          FormNumberWidget(
                                            title: "${item.name}",
                                            onClick: () {
                                              Navigator.pushNamed(
                                                  widget.tabContext,
                                                  DynamicFormScreen.id,
                                                  arguments: FormNumberArgument(
                                                      taskNo:
                                                          schedules
                                                                  .task?.taskNo ??
                                                              "",
                                                      scheduleId: schedules
                                                              .id ??
                                                          "",
                                                      formNo: "${item.formNo}",
                                                      formId: "${item.formId}",
                                                      formName: "${item.name}",
                                                      siteId:
                                                          "${schedules.site?.id}",
                                                      latitude:
                                                          "${schedules.site?.latitude}",
                                                      longitude:
                                                          "${schedules.site?.longitude}",
                                                      siteName:
                                                          "${schedules.site?.name}"));
                                            },
                                          )))
                                      : List.from(
                                          _myChecklistModelList!.map(
                                            (item) => FormNumberWidget(
                                                title: "${item.name}",
                                                onClick: () {
                                                  Navigator.pushNamed(
                                                          widget.tabContext,
                                                          DynamicFormScreen.id,
                                                          arguments: FormNumberArgument(
                                                              formId:
                                                                  "${item.formId}",
                                                              taskNo: schedules
                                                                      .task
                                                                      ?.taskNo ??
                                                                  "",
                                                              scheduleId:
                                                                  schedules.id ??
                                                                      "",
                                                              formNo:
                                                                  "${item.formNo}",
                                                              formName:
                                                                  "${item.name}",
                                                              siteId:
                                                                  "${schedules.site?.id}",
                                                              latitude:
                                                                  "${schedules.site?.latitude}",
                                                              longitude:
                                                                  "${schedules.site?.longitude}",
                                                              siteName:
                                                                  "${schedules.site?.name}"))
                                                      .then((_) {
                                                    // This block runs when you have returned back to the 1st Page from 2nd.
                                                    context
                                                        .read<ChecklistCubit>()
                                                        .getChecklist(
                                                            params:
                                                                const ChecklistParams(
                                                                    formNo:
                                                                        ""));
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

    for (var swcDetails in _myChecklistModelList!) {
      if (swcDetails.formNo
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase())) {
        _searchResult.add(swcDetails);
      }
    }
    setState(() {});
  }
}
