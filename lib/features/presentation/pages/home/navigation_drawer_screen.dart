import 'package:cached_network_image/cached_network_image.dart';
import 'package:eminencetel/features/presentation/bloc/login_cubit.dart';
import 'package:eminencetel/features/presentation/pages/home/certificates/certificates_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/tasks/finished_task_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/tasks/inprogress_task_screen.dart';
import 'package:eminencetel/features/presentation/pages/login_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/schedules/schedules_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/tasks/all_task_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/tasks/today_task_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/tasks/unfinished_tasks_screen.dart';
import 'package:eminencetel/features/presentation/pages/task/calendar_screen.dart';
import 'package:eminencetel/features/presentation/pages/widgets/custom_button.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/custom_text_styles.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/injection_container.dart';
import 'package:eminencetel/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerScreen extends StatefulWidget {
  static const String id = 'navigation_drawer';

  const NavigationDrawerScreen({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerScreen> createState() => _NavigationDrawerScreenState();
}

class _NavigationDrawerScreenState extends State<NavigationDrawerScreen> {
  int _selectedIndex = 0;

  var user = getIt<LoginCubit>().getUser();

  MethodChannel channel = const MethodChannel('callback_channel');

  Future<void> stopServiceFromNativeCode() async {
    try {
      await channel.invokeMethod('stopService');
    } on PlatformException catch (e) {
      logger.d(e.stacktrace);
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    TodayTasksScreen(),
    InProgressTasksScreen(),
    UnfinishedTasksScreen(),
    FinishedTaskScreen(),
    AllTasksScreen(),
    SchedulesScreen(),
    CertificatesScreen(),
    CalendarScreen()
  ];

  static List<String> titles = <String>[
    LocaleStrings.navigation_drawer_menu_my_task,
    LocaleStrings.navigation_drawer_menu_in_progress_task,
    LocaleStrings.navigation_drawer_menu_unfinished_task,
    LocaleStrings.navigation_drawer_menu_completed_task,
    LocaleStrings.navigation_drawer_menu_all_task,
    LocaleStrings.navigation_drawer_menu_schedules,
    LocaleStrings.navigation_drawer_menu_certificates,
    LocaleStrings.navigation_drawer_menu_calendar,
    LocaleStrings.navigation_drawer_menu_logout,
    LocaleStrings.navigation_drawer_menu_buzzer_off
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appBarColor,
        title: Text(titles[_selectedIndex]),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider("${user.profileImage}")
                      )
                    )
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${user.fullName}",
                    style: textTheme.headline6,
                  ),
                  Text(
                    "${user.email}",
                    style: textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.task),
                title: Text(titles[0]),
                selected: _selectedIndex == 0,
                selectedColor: CustomColors.primary,
                onTap: () => _onItemTapped(0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.task_outlined),
                title: Text(titles[1]),
                selected: _selectedIndex == 1,
                selectedColor: CustomColors.primary,
                onTap: () => _onItemTapped(1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.task_outlined),
                title: Text(titles[2]),
                selected: _selectedIndex == 2,
                selectedColor: CustomColors.primary,
                onTap: () => _onItemTapped(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.done),
                title: Text(titles[3]),
                selected: _selectedIndex == 3,
                selectedColor: CustomColors.primary,
                onTap: () => _onItemTapped(3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.task),
                title: Text(titles[4]),
                selected: _selectedIndex == 4,
                selectedColor: CustomColors.primary,
                onTap: () => _onItemTapped(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.task),
                title: Text(titles[5]),
                selected: _selectedIndex == 5,
                selectedColor: CustomColors.primary,
                onTap: () => _onItemTapped(5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.file_present),
                title: Text(titles[6]),
                selectedColor: CustomColors.primary,
                selected: _selectedIndex == 6,
                onTap: () => _onItemTapped(6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.calendar_month),
                title: Text(titles[7]),
                selectedColor: CustomColors.primary,
                selected: _selectedIndex == 7,
                onTap: () => _onItemTapped(7),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.logout),
                title: Text(titles[8]),
                selected: _selectedIndex == 8,
                selectedColor: CustomColors.primaryAlpha40,
                onTap: () => logoutBottomSheet(context),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedTileColor: CustomColors.primaryAlpha40,
                leading: const Icon(Icons.volume_off_outlined),
                title: Text(titles[9]),
                selected: _selectedIndex == 9,
                selectedColor: CustomColors.primaryAlpha40,
                onTap: () => stopServiceFromNativeCode(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void logoutBottomSheet(
  context,
) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return SafeArea(
            child: Container(
          color: CustomColors.white,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      LocaleStrings.navigation_drawer_bottom_sheet_message,
                      style: CustomTextStyles.bold18(),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CustomButton(
                              buttonColor: CustomColors.lightHash,
                              text: LocaleStrings
                                  .navigation_drawer_bottom_sheet_no,
                              onClick: () {
                                Navigator.of(context).pop();
                              }),
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CustomButton(
                              buttonColor: CustomColors.primary,
                              text: LocaleStrings.navigation_drawer_bottom_sheet_yes,
                              onClick: () async {
                                try {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.clear();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      LoginScreen.id,
                                      (Route<dynamic> route) => false);
                                } catch (e) {
                                  logger.d(e);
                                }
                              }),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      });
}
