import 'package:beresto/api/api_service.dart';
import 'package:beresto/model/restaurant_detail.dart';
import 'package:beresto/provider/restaurant_detail_provider.dart';
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'add_review_page.dart';

class ReviewPage extends StatelessWidget {
  final List<CustomerReview> restaurantReview;
  final String restaurantId;

  ReviewPage({@required this.restaurantReview, @required this.restaurantId});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      /// State management Provider ini digunakan pada saat menampilkan Detail Restaurant dan Review Restaurant
      create: (_) => RestaurantDetailAndReviewProvider(
          apiService: ApiService(), restaurantId: restaurantId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ulasan Pengguna'),
          elevation: 0,
          backgroundColor: Colors.orangeAccent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Route route = MaterialPageRoute(
              builder: (context) => AddReviewPage(
                restaurantId: restaurantId,
              ),
            );
            Navigator.push(context, route);
          },
          child: Icon(Icons.comment),
          backgroundColor: Colors.orange,
        ),
        body: Consumer<RestaurantDetailAndReviewProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: _shimmerLoadingSkeleton(),
              );
            } else if (state.state == ResultState.HasData) {
              return Container(
                color: Color(0xffF0F2F9),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurantReview.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var review = restaurantReview[index];
                    return ReviewItemData(
                      review: review,
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(state.message, textAlign: TextAlign.center,),
                  ],
                ),
              );
            }
          },
        ),

        ),

      );
  }
  Widget _shimmerLoadingSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350],
      highlightColor: Colors.grey[200],
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          );
        },
      ),
    );
}




}

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


