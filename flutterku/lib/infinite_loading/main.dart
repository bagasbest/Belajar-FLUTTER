import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterku/infinite_loading/bloc/post_bloc.dart';
import 'package:flutterku/infinite_loading/ui/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      builder: (context) => PostBloc()..add(PostEvent()),
      child: MainPage(),
    ));
  }
}
