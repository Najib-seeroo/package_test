import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_details/data/models/get_restaurant_details_response.dart';
import 'package:mynewpackage/app/modules/restaurants_details/data/restaurant_details_repository.dart';

class RestaurantsDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RestaurantDetailsRepository restaurantDetailsRepository =
      Get.put(RestaurantDetailsRepository());
  RxList<Restaurant> restaurantDetails =
      List<Restaurant>.empty(growable: true).obs;

  Future<bool> getRestaurantdetails(
      {required String restaurantId,
      required int page,
      required int limit}) async {
    isLoading(true);
    await restaurantDetailsRepository
        .getRestaurantDetails(restaurantId, 1, 1)
        .then((value) {
      if ((value.data != null) && (value.status == 200)) {
        restaurantDetails.addAll(value.data?.restaurant ?? []);
        isLoading(false);
        return true;
      } else {
        isLoading(false);
        getRestaurantdetails(restaurantId: restaurantId, page: 1, limit: 1);
        return false;
      }
    });
    return false;
  }
}
