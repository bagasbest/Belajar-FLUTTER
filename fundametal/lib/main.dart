import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fundametal/helper/database_article_helper.dart';
import 'package:fundametal/helper/preferences_helper.dart';
import 'package:fundametal/provider/database_article_provider.dart';
import 'package:fundametal/provider/news_provider.dart';
import 'package:fundametal/provider/preferences_provider.dart';
import 'package:fundametal/provider/schduling_provider.dart';
import 'package:fundametal/screen/alarm_manager_home_page.dart';
import 'package:fundametal/screen/cupertino.dart';
import 'package:fundametal/screen/custom_widget.dart';
import 'package:fundametal/screen/explicit_animation.dart';
import 'package:fundametal/screen/gesture_detection.dart';
import 'package:fundametal/screen/latihan_cupertino.dart';
import 'package:fundametal/screen/named_navigation_routing.dart';
import 'package:fundametal/screen/news_app.dart';
import 'package:fundametal/screen/note_list_page.dart';
import 'package:fundametal/screen/notification_detail_page.dart';
import 'package:fundametal/screen/notification_home_page.dart';
import 'package:fundametal/screen/read_and_write_file.dart';
import 'package:fundametal/screen/shared_preference.dart';
import 'package:fundametal/screen/sliver_list_and_grid.dart';
import 'package:fundametal/screen/slivers.dart';
import 'package:fundametal/screen/state_management.dart';
import 'package:fundametal/service/api_service.dart';
import 'package:fundametal/utils/alarm_manager_background_service.dart';
import 'package:fundametal/utils/article_background_service.dart';
import 'package:fundametal/utils/article_notification_helper.dart';
import 'package:fundametal/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ArticleNotificationHelper _notificationHelper =
      ArticleNotificationHelper();
  final ArticleBackgroundService _service = ArticleBackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseArticleProvider(
            databaseArticleHelper: DatabaseArticleHelper(),
          ),
        ),
      ],
      child: NewsApp(),
    );
  }
}

// void main () => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return NewsApp();
//   }
// }
