import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/utils/alarm_manager_background_service.dart';

class AlarmManagerHomePage extends StatefulWidget {
  @override
  _AlarmManagerHomePageState createState() => _AlarmManagerHomePageState();
}

class _AlarmManagerHomePageState extends State<AlarmManagerHomePage> {
  static const title = 'Simple Alarm Manager';

  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    port.listen(
      (_) async => await _service.someTask(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                onPressed: () async {
                  await AndroidAlarmManager.oneShot(
                      Duration(seconds: 5), 1, BackgroundService.callback,
                      exact: true, wakeup: true);
                },
                child: Text('Alarm with Delayed (Once)'),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  'Alarm with Date Time (Once)',
                ),
                onPressed: () async {
                  await AndroidAlarmManager.oneShotAt(
                    DateTime.now().add(Duration(seconds: 5)),
                    2,
                    BackgroundService.callback,
                    exact: true,
                    wakeup: true,
                  );
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  'Alarm with Periodic',
                ),
                onPressed: () async {
                  await AndroidAlarmManager.periodic(
                    Duration(minutes: 1),
                    3,
                    BackgroundService.callback,
                    startAt: DateTime.now(),
                    exact: true,
                    wakeup: true,
                  );
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  'Cancel Alarm by Id',
                ),
                onPressed: () async {
                  await AndroidAlarmManager.cancel(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
