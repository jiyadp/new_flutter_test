import 'package:eminencetel/features/presentation/pages/buzzer/buzzer.dart';
import 'package:eminencetel/features/presentation/pages/forms/components/dropdown_selection_screen.dart';
import 'package:eminencetel/features/presentation/pages/forms/dynamic_form_screen.dart';
import 'package:eminencetel/features/presentation/pages/forms/dynamic_photos_tab_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/tasks/all_task_screen.dart';
import 'package:eminencetel/features/presentation/pages/login_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/navigation_drawer_screen.dart';
import 'package:eminencetel/features/presentation/pages/forms/photos/photo_gallery_screen.dart';
import 'package:eminencetel/features/presentation/pages/forms/photos/photo_uploading_screen.dart';
import 'package:eminencetel/features/presentation/pages/schedules/schedule_tasks_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/schedules/schedules_screen.dart';
import 'package:eminencetel/features/presentation/pages/sheet_selection_screen.dart';
import 'package:eminencetel/features/presentation/pages/splash_screen.dart';
import 'package:eminencetel/features/presentation/pages/task/task_details_screen.dart';
import 'package:eminencetel/features/presentation/pages/home/tasks/unfinished_tasks_screen.dart';
import 'package:eminencetel/features/presentation/res/custom_colors.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/firebase_options.dart';
import 'package:eminencetel/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 1,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 120,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Toggle this to cause an async error to be thrown during initialization
// and to test that runZonedGuarded() catches the error
const _kShouldTestAsyncErrorOnInit = false;

// Toggle this for testing Crashlytics in your app locally.
const _kTestingCrashlytics = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };


  await di.init();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with RouteAware {

  late Future<void> _initializeFlutterFireFuture;

  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeFlutterFireFuture = _initializeFlutterFire();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        title: LocaleStrings.appName,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: CustomColors.mainColor,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SheetSelectionScreen.id: (context) => const SheetSelectionScreen(),
          PhotoUploadingScreen.id: (context) => PhotoUploadingScreen(),
          DynamicPhotosTabScreen.id: (context) => const DynamicPhotosTabScreen(),
          PhotoGalleryScreen.id: (context) => const PhotoGalleryScreen(),
          NavigationDrawerScreen.id: (context) => const NavigationDrawerScreen(),
          TaskDetailsScreen.id: (context) => const TaskDetailsScreen(),
          UnfinishedTasksScreen.id: (context) => const UnfinishedTasksScreen(),
          DropdownSelectionScreen.id: (context) => const DropdownSelectionScreen(),
          DynamicFormScreen.id: (context) => const DynamicFormScreen(),
          SchedulesScreen.id: (context) => const SchedulesScreen(),
          AllTasksScreen.id: (context) => const AllTasksScreen(),
          SchedulesTaskScreen.id: (context) => const SchedulesTaskScreen(),
          BuzzerScreen.id: (context) => const BuzzerScreen(),
        });
  }
}
