import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Cupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSelected = true;
  double _sliderValue = 75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adaptive Widget'),
        leading: Icon(Icons.menu),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch.adaptive(
              value: _isSelected,
              onChanged: (bool value) {
                setState(() {
                  _isSelected = value;
                });
              },
            ),
            Slider.adaptive(
              value: _sliderValue,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(
                  () {
                    _sliderValue = value;
                  },
                );
              },
            ),
            defaultTargetPlatform == TargetPlatform.iOS
                ? Text('iOS')
                : Text('Android'),
          ],
        ),
      ),
    );
  }
}
