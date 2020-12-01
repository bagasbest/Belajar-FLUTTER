import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<bool> isSelected = [true, false, false];
  ColorFilter colorFilter =
      ColorFilter.mode(Colors.lightBlue, BlendMode.screen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColorFiltered(
        colorFilter: colorFilter,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Widget Baru"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(
                  "Ini adalah selectable text",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  showCursor: true,
                  cursorWidth: 3,
                  cursorColor: Colors.red,
                ),
                SizedBox(
                  height: 10,
                ),
                ToggleButtons(
                  children: [
                    Icon(Icons.alarm),
                    Icon(Icons.add_chart),
                    Icon(Icons.add_comment)
                  ],
                  isSelected: isSelected,
                  onPressed: (index) {
                    setState(() {
                      if (index == 0) {
                        colorFilter = ColorFilter.mode(
                            Colors.lightBlue, BlendMode.screen);
                      } else if (index == 1) {
                        colorFilter =
                            ColorFilter.mode(Colors.green, BlendMode.softLight);
                      } else
                        colorFilter =
                            ColorFilter.mode(Colors.purple, BlendMode.multiply);

                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = (i == index) ? true : false;
                      }
                      //isSelected[index] = !isSelected[index];
                    });
                  },
                  fillColor: Colors.red[50],
                  selectedColor: Colors.red,
                  selectedBorderColor: Colors.red,
                  splashColor: Colors.lightBlue,
                  highlightColor: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
