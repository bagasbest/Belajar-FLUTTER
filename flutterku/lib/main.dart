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
          appBar: AppBar(title: Text("Welcome to the club Flutter Dev"),),
          body: Center(child: Text("Haloo sobat Flutter")),
      ),
    );
  }
}



