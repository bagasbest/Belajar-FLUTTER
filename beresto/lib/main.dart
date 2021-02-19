import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:beresto/api/api_service.dart';
import 'package:beresto/provider/database_provider.dart';
import 'package:beresto/provider/preferences_provider.dart';
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:beresto/provider/schduling_provider.dart';
import 'package:beresto/screen/favorite_resto_page.dart';
import 'package:beresto/screen/home_page.dart';
import 'package:beresto/screen/list_of_restautant.dart';
import 'package:beresto/screen/settings_resto_page.dart';
import 'package:beresto/service/background_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/database_helper.dart';
import 'helper/notification_helper.dart';
import 'helper/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject(context);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) =>
              PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance(),
                ),
              ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
          title: 'BeResto App',
          theme: provider.themeData,
          builder: (context, child) {
            return CupertinoTheme(
              data: CupertinoThemeData(
                brightness:
                provider.isNightTheme ? Brightness.dark : Brightness.light,
              ),
              child: Material(
                child: child,
              ),
            );
          },
          home: HomePage(),
        );
      }),
    );
  }
}
