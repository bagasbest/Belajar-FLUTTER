import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:beresto/helper/date_time_helper.dart';
import 'package:beresto/service/background_service.dart';
import 'package:flutter/material.dart';


class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Restaurant Of The Day Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Restaurant Of The Day Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}