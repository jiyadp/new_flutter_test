import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:eminencetel/features/presentation/bloc/schedule_details_cubit.dart';
import 'package:eminencetel/features/presentation/pages/task/tabs/checklist_screen.dart';
import 'package:eminencetel/features/presentation/pages/task/tabs/comments_screen.dart';
import 'package:eminencetel/features/presentation/pages/task/tabs/documents_screen.dart';
import 'package:eminencetel/features/presentation/pages/task/tabs/overview_screen.dart';
import 'package:eminencetel/features/presentation/pages/task/tabs/schedule_details_screen.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/buzzer_stream_controller.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({Key? key}) : super(key: key);
  static const String id = 'task_details_screen';

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TaskDataModel argumentsModel;
  var scheduleDetailsCubit = getIt<ScheduleDetailsCubit>();
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BuzzerStreamController().initEventStream();

    argumentsModel =
        ModalRoute.of(context)!.settings.arguments as TaskDataModel;
    final tabs = [
      Tab(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: tabIndex == 0
                ? CustomColors.bublecolor
                : CustomColors.unseletbublecolor,
            border: Border.all(
              color: tabIndex == 0
                  ? CustomColors.bublecolor
                  : CustomColors.unseletbublecolor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Text(LocaleStrings.task_details_screen_tab_title_overview),
      )),
      Tab(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: tabIndex == 1
                  ? CustomColors.bublecolor
                  : CustomColors.unseletbublecolor,
              border: Border.all(
                color: tabIndex == 1
                    ? CustomColors.bublecolor
                    : CustomColors.unseletbublecolor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Text(LocaleStrings.task_details_screen_tab_title_details),
        ),
      ),
      Tab(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: tabIndex == 2
                  ? CustomColors.bublecolor
                  : CustomColors.unseletbublecolor,
              border: Border.all(
                color: tabIndex == 2
                    ? CustomColors.bublecolor
                    : CustomColors.unseletbublecolor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Text(LocaleStrings.task_details_screen_tab_title_documents),
        ),
      ),
      Tab(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: tabIndex == 3
                  ? CustomColors.bublecolor
                  : CustomColors.unseletbublecolor,
              border: Border.all(
                color: tabIndex == 3
                    ? CustomColors.bublecolor
                    : CustomColors.unseletbublecolor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Text(LocaleStrings.task_details_screen_tab_title_comments),
        ),
      ),
      Tab(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: tabIndex == 4
                  ? CustomColors.bublecolor
                  : CustomColors.unseletbublecolor,
              border: Border.all(
                color: tabIndex == 4
                    ? CustomColors.bublecolor
                    : CustomColors.unseletbublecolor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Text(LocaleStrings.task_details_screen_tab_title_checklist),
        ),
      ),
    ];

    final tabViews = [
      OverviewScreen(
        tabContext: context,
        taskId: argumentsModel.scheduleId,
      ),
      const ScheduleDetailsScreen(),
      DocumentsScreen(
        tabContext: context,
      ),
      const CommentsScreen(),
      ChecklistScreen(
        tabContext: context,
      ),
    ];
    return BlocProvider<ScheduleDetailsCubit>(
      create: (_) => scheduleDetailsCubit..getScheduleDetails(argumentsModel),
      child: BlocBuilder<ScheduleDetailsCubit, DataState<ScheduleDetailsModel>>(
        builder: (context, state) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (state.isFailure) {
              final snackBar = SnackBar(content: Text("${state.error}"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state.isSuccess) {
              state.data?.message;
            }
          });
          return DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Task Details'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: CustomColors.primary,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Container(
                    color: CustomColors.white,
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelColor: CustomColors.bubletextcolor,
                      unselectedLabelColor: Colors.grey,
                      indicatorPadding: const EdgeInsets.all(8),
                      unselectedLabelStyle: const TextStyle(),
                      isScrollable: true,
                      tabs: tabs,
                      onTap: (index) {
                        setState(() {
                          tabIndex = index;
                        });
                      },
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      indicatorWeight: 4,
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: tabViews,
              ),
            ),
          );
        },
      ),
    );
  }
}
