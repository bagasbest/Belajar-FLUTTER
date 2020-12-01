import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:bloc/bloc.dart';

void main() async {
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<ColorBloc>(
          builder: (context) => ColorBloc(), child: MainPage()),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    ColorBloc bloc = BlocProvider.of<ColorBloc>(context);

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              bloc..dispatch(ColorEvent.to_amber);
            },
            backgroundColor: Colors.amber,
            child: Icon(Icons.face),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              bloc.dispatch(ColorEvent.to_lightBlue);
            },
            backgroundColor: Colors.lightBlue,
            child: Icon(Icons.face),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Bloc Flutter Package"),
      ),
      body: Center(
        child: BlocBuilder<ColorBloc, Color>(
          builder: (context, currentColor) => AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: 100,
            height: 100,
            color: currentColor,
          ),
        ),
      ),
    );
  }
}

enum ColorEvent { to_amber, to_lightBlue }

class ColorBloc extends HydratedBloc<ColorEvent, Color> {
  Color get initialState => super.initialState ?? Colors.amber;

  @override
  Stream<Color> mapEventToState(ColorEvent event) async* {
    yield (event == ColorEvent.to_amber) ? Colors.amber : Colors.lightBlue;
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    try {
      return Color(json['color'] as int);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, int> toJson(Color state) {
    // TODO: implement toJson
    try {
      return {'color': state.value};
    } catch (_) {
      return null;
    }
  }
}
