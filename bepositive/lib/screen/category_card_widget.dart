import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCardWidget extends StatelessWidget {
  final IconData cardImage;
  final String cardTitle;
  final Function press;
  CategoryCardWidget({this.cardImage, this.cardTitle, this.press});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 17,
            spreadRadius: -23,
            color: Colors.grey,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                cardImage,
                size: 80,
              ),
              Text(
                cardTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
