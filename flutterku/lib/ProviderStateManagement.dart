import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider<ApplicationColor>(
      //versi 4
      create: (context) => ApplicationColor(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Consumer<ApplicationColor>(
            builder: (context, applicationColor, _) => Text(
              "Provider State Management",
              style: TextStyle(color: applicationColor.color),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ApplicationColor>(
                builder: (context, applicationColor, _) => AnimatedContainer(
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  color: applicationColor.color,
                  duration: Duration(milliseconds: 500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(margin: EdgeInsets.all(5), child: Text("AB")),
                  Consumer<ApplicationColor>(
                      builder: (context, applicationColor, _) => Switch(
                          value: applicationColor.isLightBlue,
                          onChanged: (val) {
                            applicationColor.isLightBlue = val;
                          })),
                  Container(margin: EdgeInsets.all(5), child: Text("LB"))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class ApplicationColor with ChangeNotifier {
  // _ artinya private
  bool _isLightBlue = true;

  bool get isLightBlue => _isLightBlue;
  set isLightBlue(bool value) {
    _isLightBlue = value;
    notifyListeners();
  }

  Color get color => (_isLightBlue) ? Colors.lightBlue : Colors.amber;
}
