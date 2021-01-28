import 'package:flutter/material.dart';
import 'package:fundametal/screen/cupertino.dart';
import 'package:fundametal/screen/custom_widget.dart';
import 'package:fundametal/screen/explicit_animation.dart';
import 'package:fundametal/screen/gesture_detection.dart';
import 'package:fundametal/screen/latihan_cupertino.dart';
import 'package:fundametal/screen/named_navigation_routing.dart';
import 'package:fundametal/screen/news_app.dart';
import 'package:fundametal/screen/sliver_list_and_grid.dart';
import 'package:fundametal/screen/slivers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsApp();
  }
}
