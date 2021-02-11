import 'dart:convert';
import 'package:beresto/model/restaurant_detail.dart';
import 'package:beresto/model/restaurant_list.dart';
import 'package:beresto/model/review.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> listOfRestaurants(String query) async {
    if (query.isEmpty || query == null) {
      final response = await http.get(_baseUrl + 'list');
      if (response.statusCode == 200) {
        return RestaurantList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load list of restaurants');
      }
    } else {
      final response = await http.get(_baseUrl + 'search?q=' + query);
      if (response.statusCode == 200) {
        return RestaurantList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load list of restaurants');
      }
    }
  }

  Future<RestaurantDetail> detailOfRestaurants(String _id) async {
    final response = await http.get(_baseUrl + 'detail/' + _id);
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail of restaurants');
    }
  }

  Future<CustomerRevieww> review(
      String _id, String _name, String _review) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Auth-Token': '12345',
    };
    final body = jsonEncode({
      'id': _id,
      'name': _name,
      'review': _review,
    });

    final response = await http.post(
      _baseUrl + 'review',
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return reviewFromJson(responseString);
    } else {
      throw Exception('Failed to load review page');
    }
  }
}
