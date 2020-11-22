import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Latihan Membuat Button'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: () {},
                color: Colors.amber,
                shape: StadiumBorder(),
                child: Text('Raised Button'),
              ),

              //Button Customize
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(3),
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pinkAccent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Material(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(3),
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Customize Button',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
