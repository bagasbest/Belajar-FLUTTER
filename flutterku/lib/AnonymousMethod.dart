import 'package:flutter/material.dart';

//fungsi main adalah fungsi yang dijalankan pertama kali ketika aplikasi dijalankan
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = "Ini adalah Text";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Anonymous Method"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Ini adalah text"),
              RaisedButton(
                  child: Text("Tekan saya"),
                  //anonymous method
                  onPressed: () {
                    setState(() {
                      message = "Tombol telah ditekan!";
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
