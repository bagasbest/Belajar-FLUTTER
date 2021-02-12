import 'package:beresto/api/api_service.dart';
import 'package:beresto/model/restaurant_detail.dart';
import 'package:flutter/cupertino.dart';

enum ResultState { Loading, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({this.apiService, @required this.restaurantId}) {
    _fetchDetailRestaurant();
  }

  RestaurantDetail _restaurantDetail;
  String _message = '';
  ResultState _state;

  String get message => _message;

  RestaurantDetail get detail => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final detailOfRestaurant = await apiService.detailOfRestaurants(restaurantId);
      _state = ResultState.HasData;
      notifyListeners();
      return _restaurantDetail = detailOfRestaurant;

    } catch (err) {
      _state = ResultState.Error;
      notifyListeners();
      print(err);
      return _message = 'Maaf, Sedang Terjadi Error Bung, Silahkan Periksa Jaringan Internet Anda atau Mulai Ulang Aplikasi';
    }
  }
}
