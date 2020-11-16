import 'package:flutter/material.dart';

//fungsi main adalah fungsi yang dijalankan pertama kali ketika aplikasi dijalankan
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //using material design
    return MaterialApp(
      //widget scaffold adalah tampilan dasar dari sebuah aplikasi android
      //scaffold punya banyak properti
      //kita gunakan properti AppBar
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome to the club Flutter Dev"),
        ),
        body: Center(
            child: Container(
                color: Colors.lightBlue,
                width: 150,
                height: 50,
                child: Text(
                  "Haloo sobat Flutter",
                  // maxLines: 2,
                  // overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ))),
      ),
    );
  }
}
