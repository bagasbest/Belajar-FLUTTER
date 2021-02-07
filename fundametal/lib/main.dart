import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fundametal/screen/alarm_manager_home_page.dart';
import 'package:fundametal/screen/cupertino.dart';
import 'package:fundametal/screen/custom_widget.dart';
import 'package:fundametal/screen/explicit_animation.dart';
import 'package:fundametal/screen/gesture_detection.dart';
import 'package:fundametal/screen/latihan_cupertino.dart';
import 'package:fundametal/screen/named_navigation_routing.dart';
import 'package:fundametal/screen/news_app.dart';
import 'package:fundametal/screen/notification_detail_page.dart';
import 'package:fundametal/screen/notification_home_page.dart';
import 'package:fundametal/screen/sliver_list_and_grid.dart';
import 'package:fundametal/screen/slivers.dart';
import 'package:fundametal/screen/state_management.dart';
import 'package:fundametal/utils/alarm_manager_background_service.dart';
import 'package:fundametal/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final NotificationHelper _notificationHelper = NotificationHelper();
  //
  // await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  // _notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);

  // runApp(
  //   MaterialApp(
  //     initialRoute: NotificationHomePage.routeName,
  //     routes: {
  //       NotificationHomePage.routeName: (context) => NotificationHomePage(),
  //       NotificationDetailPage.routeName: (context) => NotificationDetailPage(),
  //     },
  //   ),
  // );

  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  AndroidAlarmManager.initialize();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlarmManagerHomePage();
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
