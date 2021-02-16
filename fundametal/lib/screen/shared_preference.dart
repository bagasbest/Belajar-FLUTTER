import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference extends StatefulWidget {
  @override
  _SharedPreferenceState createState() => _SharedPreferenceState();
}

class _SharedPreferenceState extends State<SharedPreference> {
  int _number = 0;
  static const String counterNumberPrefs = 'counterNumber';

  @override
  void initState() {
    super.initState();
    _loadCounterNumber();
  }

  _saveCounterNumber() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(counterNumberPrefs, _number);
  }

  void _loadCounterNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(
      () {
        _number = prefs.getInt(counterNumberPrefs) ?? 0;
      },
    );
  }

  void _resetCounterNumber() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(counterNumberPrefs);
    _loadCounterNumber();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Belajar Shared Preference'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You have pushed the button many times'),
              Text(
                _number.toString(),
                style: TextStyle(fontSize: 30),
              ),
              OutlinedButton(
                onPressed: () {
                  _resetCounterNumber();
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          elevation: 10,
          onPressed: () {
            setState(
              () {
                _number++;
                _saveCounterNumber();
              },
            );
          },
        ),
      ),
    );
  }
}
