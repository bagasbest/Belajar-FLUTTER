import 'dart:convert';
import 'dart:io';
import 'package:beresto/model/resturant.dart';
import 'package:beresto/screen/detail_resto_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  String currenTime() {
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
                      currenTime(),
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

class ListOfRestaurant extends StatefulWidget {
  @override
  _ListOfRestaurantState createState() => _ListOfRestaurantState();
}

class _ListOfRestaurantState extends State<ListOfRestaurant> {
  List _items = [];

  /// Fetch content from json file
  Future<dynamic> readJson() async {
    final String response =
        await rootBundle.loadString('assets/local_restaurant.json');
    final data = await json.decode(response);
    _items = data["restaurants"];
    print('AAAAAAAAA');
  }

  @override
  void initState() {
    super.initState();
    this.readJson();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readJson(),
      builder: (context, snapshot) {
        return (_items.length > 0)
            ? ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Route route = MaterialPageRoute(
                        builder: (context) => DetailRestoPage(
                          data: _items[index],
                        ),
                      );
                      Navigator.push(context, route);
                    },
                    splashColor: Colors.grey,
                    child: Card(
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        leading: Hero(
                          tag: _items[index]['pictureId'],
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  _items[index]['pictureId'],
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        title: Text(
                          _items[index]['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.map_pin,
                                  size: 20,
                                  color: Colors.orangeAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _items[index]['city'],
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.star_fill,
                                  size: 20,
                                  color: Colors.orangeAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _items[index]['rating'].toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }
}
