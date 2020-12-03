import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Person selectedPerson;

  List<Person> persons = [Person("Doni"), Person("Joko")];

  List<DropdownMenuItem> generateItem(List<Person> persons) {
    List<DropdownMenuItem> items = [];
    for (var item in persons) {
      items.add(DropdownMenuItem(
        child: Text(item.name),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dropdown"),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: DropdownButton(
                isExpanded: true,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                items: generateItem(persons),
                onChanged: (item) {
                  setState(() {
                    selectedPerson = item;
                  });
                },
                value: selectedPerson,
              ),
            ),
            Text(
              (selectedPerson != null)
                  ? selectedPerson.name
                  : "Belum ada yang terpilih",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class Person {
  String name;
  Person(this.name);
}
