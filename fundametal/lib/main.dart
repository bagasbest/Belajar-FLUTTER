import 'package:flutter/material.dart';
import 'package:fundametal/screen/custom_widget.dart';
import 'package:fundametal/screen/gesture_detection.dart';
import 'package:fundametal/screen/named_navigation_routing.dart';
import 'package:fundametal/screen/news_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsApp();
  }
}
