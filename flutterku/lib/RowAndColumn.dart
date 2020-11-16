import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Latihan Row dan Column"),
        ),
        //sekarang body di ubah menjadi Column atau Row
        //Column kebawah, Row kesamping
        body: Column(
          //main axis alignment pada properti Column akan mengatur Column secara vertikal
          //main axis alignment pada properti Row akan mengatur Column secara horizontal
          mainAxisAlignment: MainAxisAlignment.center,
          //cross Axis di column akan menyusun secara horizontal
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Text 1"),
            Text("Text 2"),
            Text("Text 3"),
            //tambah properti Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Text 4"),
                Text("Text 5"),
                Text("Text 6")
              ],
            )
          ],
        ),
      ),
    );
  }
}
