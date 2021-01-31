import 'dart:convert';

import 'package:beresto/screen/detail_resto_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    print('DEBUG');
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
