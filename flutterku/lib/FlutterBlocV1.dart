import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterku/bloc/counter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<CounterBloc>(
          builder: (context) => CounterBloc(), child: MainPage()),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterBloc cbloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("flutter_bloc ver 1.0"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, counterState) => Text(
                counterState.value.toString(),
                style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  child: Icon(Icons.arrow_upward),
                  onPressed: () {
                    cbloc.add(Increment());
                  },
                  backgroundColor: Colors.lightBlue,
                ),
                SizedBox(
                  width: 40,
                ),
                FloatingActionButton(
                  child: Icon(Icons.arrow_downward),
                  onPressed: () {
                    cbloc.add(Decrement());
                  },
                  backgroundColor: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
