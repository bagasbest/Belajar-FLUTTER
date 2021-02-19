import 'package:flutter/material.dart';

class ReviewItemData extends StatelessWidget {
  final review;

  ReviewItemData({@required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  starIcon(),
                  starIcon(),
                  starIcon(),
                  starIcon(),
                  starIcon(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Oleh ${review.name}',
              ),
              Text(
                'Di posting pada ${review.date}',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Text(review.review),
            ],
          ),
        ),
      ),
    );
  }

  Icon starIcon() {
    return Icon(
      Icons.star,
      color: Colors.orange,
      size: 20,
    );
  }
}
