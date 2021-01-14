import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: Text("State less/full Widget"),
        ),
        body: Center(
          child: PerubahanTeks(text: "Hello World!..."),
        ),
      ),
    );
  }
}

class PerubahanTeks extends StatefulWidget {
  final String text;
  PerubahanTeks({this.text});
  @override
  _PerubahanTeksState createState() => _PerubahanTeksState();
}

class _PerubahanTeksState extends State<PerubahanTeks> {
  double _ukuranText = 16.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.text,
          style: TextStyle(fontSize: _ukuranText),
        ),
        RaisedButton(
            child: Text("Perbesar"),
            onPressed: () {
              setState(() {
                _ukuranText = 32.0;
              });
            })
      ],
    );
  }
}
