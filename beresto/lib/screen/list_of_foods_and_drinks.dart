import 'package:beresto/model/restaurant_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'card_menu_of_list_foods_and_drinks.dart';

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


