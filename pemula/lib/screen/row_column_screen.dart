import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Row And Column"),
        ),
        body: Column(
          children: [
            TextFields(),
            RowIcon(),
          ],
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(10.0),
      child: Card(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Text(
            "Halo All",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class RowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(icon: Icon(Icons.share), onPressed: () {}),
        IconButton(icon: Icon(Icons.thumb_up), onPressed: () {}),
        IconButton(icon: Icon(Icons.thumb_down), onPressed: () {}),
      ],
    );
  }
}
