import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter tipografi'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Contoh 01 (Tanpa Apapun)',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Contoh 01 (Small Caps)',
              style: TextStyle(
                fontSize: 20,
                fontFeatures: [FontFeature.enable('smcp')],
              ),
            ),
            Text(
              'Contoh 1/2 (Small Caps & Frac)',
              style: TextStyle(
                fontSize: 20,
                fontFeatures: [
                  FontFeature.enable('smcp'),
                  FontFeature.enable('frac')
                ],
              ),
            ),
            Text(
              'Contoh 1/2 (contoh cardo tanpa apapun)',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Cardo',
                  fontFeatures: [FontFeature.oldstyleFigures()]),
            ),
          ],
        ),
      ),
    );
  }
}
