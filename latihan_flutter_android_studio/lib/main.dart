import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//shortcut untuk membuat statelessWidget  = stl + Center
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // using material design
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Aplikasi Hello World"),
        ),
        body: Center(
            child: Container(
                color: Colors.pink,
                width: 150,
                height: 100,
                child: Text(
                  "Selamat datang dan Hello World!, saya sedang melatih kemampuan saya",
                  // maxLines: 2,
                  // overflow ellipsis memberikan ... pada screen yang menandakan ada lanjutan text yang terpotong
                  // overflow clip tetap seperti maxLines
                  // overflow: TextOverflow.clip,
                  // softWrap: false,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ))),
      ),
    );
  }
}
