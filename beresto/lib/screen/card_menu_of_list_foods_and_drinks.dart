import 'package:beresto/model/restaurant_detail.dart';
import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final menu;
  final Restaurant data;

  CardMenu({this.menu, this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding:
        EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/' +
                    data.pictureId,
                height: 50,
                width: 60,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              menu,
            ),
          ],
        ),
      ),
    );
  }
}