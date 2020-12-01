import 'package:flutter/material.dart';
import 'package:flutterku/AnonymousMethod.dart';
import 'package:provider/provider.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Custom Progress Bar"),
        ),
        body: Center(
          //ngambil dari konstruktor
          child: ChangeNotifierProvider<TimeState>(
            create: (context) => TimeState(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<TimeState>(
                    builder: (context, timeState, _) =>
                        CustomProgressBar(200, 15, timeState.time)),
                SizedBox(
                  height: 10,
                ),
                Consumer<TimeState>(
                  builder: (context, timeState, _) => RaisedButton(
                    child: Text(
                      "Start",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.lightBlue,
                    onPressed: () {
                      Timer.periodic(Duration(seconds: 1), (timer) {
                        if (timeState.time == 0)
                          timer.cancel();
                        else
                          timeState.time -= 1;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  //kostruktor
  final double width;
  //value saat ini
  final int value;
  //maksimum value;
  final int totalValue;
  CustomProgressBar(this.width, this.totalValue, this.value);

  @override
  Widget build(BuildContext context) {
    double ratio = value / totalValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.timer),
        Stack(
          children: <Widget>[
            Container(
              width: width,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300]),
            ),
            Material(
              borderRadius: BorderRadius.circular(5),
              child: AnimatedContainer(
                height: 10,
                width: width * ratio,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (ratio < 0.3) ? Colors.red : Colors.green,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TimeState with ChangeNotifier {
  int _time = 15;

  int get time => _time;
  set time(int time) {
    _time = time;
    notifyListeners();
  }
}
