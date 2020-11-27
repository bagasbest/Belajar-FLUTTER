import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget myWidget = Container(
    width: 200,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.red,
      border: Border.all(color: Colors.black, width: 3),
    ),
  );

  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Animated Switch"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedSwitcher(
              child: myWidget,
              duration: Duration(seconds: 1),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: animation,
                child: child,
              ),
            ),
            Switch(
                activeColor: Colors.green,
                inactiveTrackColor: Colors.red,
                value: isOn,
                onChanged: (val) {
                  isOn = val;
                  setState(() {
                    if (isOn) {
                      myWidget = Container(
                        width: 200,
                        height: 100,
                        key: ValueKey(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(color: Colors.black, width: 3),
                        ),
                      );
                      // myWidget = SizedBox(
                      //     width: 200,
                      //     height: 100,
                      //     child: Center(child: Text("Switch On")));
                    } else {
                      myWidget = Container(
                        width: 200,
                        height: 100,
                        key: ValueKey(2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.black, width: 3),
                        ),
                      );
                    }
                  });
                })
          ],
        ),
      ),
    ));
  }
}
