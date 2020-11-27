import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();
  bool isOn = false;

  void saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("nama", controller.text);
    pref.setBool("ison", isOn);
  }

  Future<String> getNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("nama") ?? "No Name";
    //tanda tanya maksudnya akan nge-return nama kalo nama != null
  }

  Future<bool> getBool() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("ison") ?? false;
  }

  Widget myWidget = Text("Off");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Shared Preference"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xFFFF4891),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFF4891))),
                    // hintText: 'Email',
                    labelText: 'Nama',
                    labelStyle: TextStyle(color: Color(0xFFFF4891)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    child: myWidget,
                    duration: Duration(seconds: 1),
                  ),
                  Switch(
                    value: isOn,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                    onChanged: (val) {
                      setState(() {
                        isOn = val;
                        if (isOn) {
                          myWidget = Text("On");
                        } else {
                          myWidget = Text("Off");
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  RaisedButton(
                    onPressed: () {
                      getNama().then((value) {
                        controller.text = value;
                      });
                      getBool().then((value2) {
                        isOn = value2;
                        setState(() {
                          if (isOn) {
                            myWidget = Text("On");
                          } else {
                            myWidget = Text("Off");
                          }
                        });
                      });
                    },
                    child: Text("Load"),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  RaisedButton(
                    onPressed: () {
                      saveData();
                    },
                    child: Text("Save"),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
