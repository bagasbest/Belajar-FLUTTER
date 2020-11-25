import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';
import 'package:qrscan/qrscan.dart' as scanner;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = 'Output QR Scanner';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR Scan'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
              Container(
                margin: EdgeInsets.all(10),
              ),
              RaisedButton(
                child: Text('Scan'),
                //onPressed: () {},
                onPressed: () async {
                  text = await scanner.scan();
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
