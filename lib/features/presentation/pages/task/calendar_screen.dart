import 'dart:collection';

import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/presentation/bloc/tasks_cubit.dart';
import 'package:eminencetel/features/presentation/pages/task/task_details_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/task_card_widget.dart';
import 'package:eminencetel/features/presentation/utils/method_utils.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:eminencetel/main.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  var taskCubit = getIt<TasksCubit>();

  final ValueNotifier<List<TasksData>> _selectedEvents = ValueNotifier([]);

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<TasksData> _getEventsForDay(DateTime day) {
    logger.d("_getEventsForDay $day");
    List<TasksData> selectedTasks = [];
    taskCubit.getAllTasks()?.data?.forEach((element) {
      var startDate = DateTime.parse("${element.task?.startDate}");
      if(day == startDate) {
        selectedTasks.add(element);
      }
    });
    return selectedTasks;
  }



  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      _selectedDays.clear();
      _selectedDays.add(selectedDay);
      _selectedEvents.value.clear();
    });
    _selectedEvents.value = _getEventsForDay(selectedDay);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            elevation: 3,
            child: TableCalendar<TasksData>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                // Use values from Set to mark multiple days as selected
                return _selectedDays.contains(day);
              },
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: ValueListenableBuilder<List<TasksData>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return TaskCardWidget(
                      taskData: value[index],
                      onClick: () {
                        Navigator.pushNamed(
                            context, TaskDetailsScreen.id,
                            arguments: TaskDataModel(
                                scheduleId: "${value[index].id}",
                                taskNo:
                                "${value[index].task?.taskNo}"));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}