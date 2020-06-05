import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int num = 0;

  void tekanTombol() {
    setState(() {
      num++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Stateful widget Demo"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  num.toString(),
                  style: TextStyle(fontSize: 10 + num.toDouble()),
                ),
                RaisedButton(
                  child: Text("Tambah bilangan"),
                  onPressed: tekanTombol,
                )
              ]),
        ),
      ),
    );
  }
}
