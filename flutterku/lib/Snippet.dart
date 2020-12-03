import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

//abis is judul klik tab
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Judul"),
      ),
      body: Container(),
    );
  }
}

//fgs
class Person {
  int _umur;

  void setterName(int value) {
    _umur = value;
  }

  int getterName() => _umur;
}
