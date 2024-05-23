import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_details/data/models/get_restaurant_details_response.dart';
import 'package:mynewpackage/app/modules/restaurants_details/data/restaurant_details_services.dart';
import 'package:mynewpackage/services/api_service.dart';

class RestaurantDetailsRepository implements RestaurantDetailsService {
  ApiService apiService = Get.find();

  @override
  Future<GetRestaurantDetailsResponse> getRestaurantDetails(String restaurantId, int page, int limit) async {
    GetRestaurantDetailsResponse getRestaurantDetailsResponse;
    Response response = await apiService.reqst(
        url: 'food/get-restaurant-by-id/$restaurantId/$page/$limit', method: Method.GET);
    log(response.statusCode.toString());
    try {
      getRestaurantDetailsResponse = GetRestaurantDetailsResponse.fromJson(response.body);
      log("inside repo ${getRestaurantDetailsResponse.status}");
      return getRestaurantDetailsResponse;
    } catch (e, s) {
      log(s.toString());
      return GetRestaurantDetailsResponse(message: "Server Error", status: 401);
    }
  }
}
