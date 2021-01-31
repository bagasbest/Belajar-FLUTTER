import 'package:beresto/widgets/list_of_restautant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  String _currentTime() {
    var now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd-MM-yyyy\nkk:mm').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Card(
            elevation: 10,
            //color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Image.asset(
              'assets/banner.png',
              fit: BoxFit.fitWidth,
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      _currentTime(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ),
                Text(
                  'BeResto\nBebas Pilih Resto Favoritmu',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Kamu mau makan/minum apa ?',
                        border: InputBorder.none,
                        icon: IconButton(
                          icon: Icon(CupertinoIcons.search),
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text('Coming Soon :)'),
                                  content: Text(
                                      'This feature will be developed soon!'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('OK'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListOfRestaurant(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
