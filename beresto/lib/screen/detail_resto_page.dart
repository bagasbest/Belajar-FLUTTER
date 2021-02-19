import 'package:beresto/api/api_service.dart';
import 'package:beresto/provider/restaurant_detail_provider.dart';
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'layout_detail_resto_page.dart';

class DetailRestoPage extends StatelessWidget {
  final restaurantId;
  final restaurantList;

  DetailRestoPage({@required this.restaurantId, this.restaurantList});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailAndReviewProvider(
          apiService: ApiService(), restaurantId: restaurantId),
      child: Scaffold(
        body: Consumer<RestaurantDetailAndReviewProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: _shimmerLoadingSkeleton(),
              );
            } else if (state.state == ResultState.HasData) {
              var restaurant = state.detail.restaurant;
              return DetailRestaurant(
                  restaurant: restaurant, restaurantList: restaurantList);
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
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
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


