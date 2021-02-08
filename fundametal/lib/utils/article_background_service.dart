import 'dart:isolate';

import 'dart:ui';

import 'package:fundametal/service/api_service.dart';
import 'package:fundametal/utils/article_notification_helper.dart';

import 'package:fundametal/main.dart';

final ReceivePort article_port = ReceivePort();

class ArticleBackgroundService {
  static ArticleBackgroundService _instance;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  ArticleBackgroundService._internal() {
    _instance = this;
  }

  factory ArticleBackgroundService() => _instance ?? ArticleBackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      article_port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('alarm fired!');
    final ArticleNotificationHelper _notificationHelper =
        ArticleNotificationHelper();
    var result = await ApiService().topHeadlines();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future <void> someTask() async {
    print ('Execute some process');
  }
}
