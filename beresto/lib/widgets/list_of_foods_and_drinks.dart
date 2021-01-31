import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOfFoodsAndDrinks extends StatelessWidget {
  ListOfFoodsAndDrinks({this.data, this.option});

  final data;
  final String option;

  @override
  Widget build(BuildContext context) {
    List _items = [];

    /// Fetch content from json file
    Future<dynamic> readJson() async {
      _items = data["menus"][option];
      print('Debug');
    }

    return FutureBuilder(
      future: readJson(),
      builder: (context, snapshot) {
        return (_items.length > 0)
            ? ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                title: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        data['pictureId'],
                        height: 50,
                        width: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      _items[index]['name'],
                    ),
                  ],
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