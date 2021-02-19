import 'package:beresto/api/api_service.dart';
import 'package:beresto/model/restaurant_list.dart';
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('Provider Test', () {
    RestaurantListAndSearchProvider restaurantProvider;
    ApiService apiService;

    setUp(() {
      apiService = MockApiService();
      when(apiService.listOfRestaurants('Melting Pot'))
          .thenAnswer((_) async => RestaurantList.fromJson(apiResponse));

      restaurantProvider = RestaurantListAndSearchProvider(
          apiService: apiService, query: 'Melting Pot');
    });

    test('Cek hasil parsing data RestaurantList.name', () async {
      var result = restaurantProvider.list.restaurants[0].name ==
          Restaurant.fromJson(testRestaurant).name;
      expect(result, true);
    });

    test('Cek hasil parsing data RestaurantList.city', () async {
      var result = restaurantProvider.list.restaurants[0].city ==
          Restaurant.fromJson(testRestaurant).city;
      expect(result, true);
    });

    test('Cek hasil parsing data RestaurantList.description', () async {
      var result = restaurantProvider.list.restaurants[0].description ==
          Restaurant.fromJson(testRestaurant).description;
      expect(result, true);
    });

  });
}

var testRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

var apiResponse = {
  "error": false,
  "message": "success",
  "count": 1,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    }
  ]
};
