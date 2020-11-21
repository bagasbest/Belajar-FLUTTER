import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Latihan Image'),
        ),
        body: Center(
          child: Container(
            color: Colors.pinkAccent,
            padding: EdgeInsets.all(3),
            child: Center(
              child: Image(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1544847558-3ccacb31ee7f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
                ),
                fit: BoxFit.contain,
                // repeat: ImageRepeat.repeatY,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
