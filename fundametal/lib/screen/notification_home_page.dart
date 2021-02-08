import 'package:flutter/material.dart';
import 'package:fundametal/utils/notification_helper.dart';
import 'file:///D:/TUBES_GALERI/Belajar-FLUTTER/fundametal/lib/utils/notification_custom_button.dart';

import '../main.dart';
import 'notification_detail_page.dart';

class NotificationHomePage extends StatefulWidget {
  static const routeName = "/";

  @override
  _NotificationHomePageState createState() => _NotificationHomePageState();
}

class _NotificationHomePageState extends State<NotificationHomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectionNotificationSubject(
        context, NotificationDetailPage.routeName);
    _notificationHelper.configureDidReceiveLocalNotificationSubject(
        context, NotificationDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Notification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              CustomButton(
                text: 'show plain notification with payload',
                press: () async {
                  await _notificationHelper
                      .showNotification(flutterLocalNotificationsPlugin);
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                text: 'Show plain notification that has no body with payload',
                press: () async {
                  await _notificationHelper.showNotificationWithNoBody(
                      flutterLocalNotificationsPlugin);
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: 'Show schedule notification with payload',
                press: () async {
                  await _notificationHelper
                      .schduleNotification(flutterLocalNotificationsPlugin);
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: 'Show grouped notifications [Android]',
                press: () async {
                  await _notificationHelper.showGroupedNotifications(
                      flutterLocalNotificationsPlugin);
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text:
                    'Show progress notification - updates every second [Android]',
                press: () async {
                  await _notificationHelper.showProgressNotification(
                      flutterLocalNotificationsPlugin);
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: 'Show big picture notification [Android]',
                press: () async {
                  await _notificationHelper.showBigPictureNotification(
                      flutterLocalNotificationsPlugin);
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: 'Show notification with attachment [iOS]',
                press: () async {
                  await _notificationHelper.showNotificationWithAttachment(
                      flutterLocalNotificationsPlugin);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
