import 'package:beresto/model/restaurant_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOfFoodsAndDrinks extends StatelessWidget {
  ListOfFoodsAndDrinks({this.data, @required this.option});

  final Restaurant data;
  final List<Category> option;

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      shrinkWrap: true,
      itemCount: option.length,
      itemBuilder: (context, index) {
        var menu = option[index].name;
        return CardMenu(menu: menu, data: data);
      },
    );
  }
}

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
