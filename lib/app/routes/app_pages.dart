import 'package:get/get.dart';

import '../modules/food/bindings/food_binding.dart';
import '../modules/food/views/food_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/restaurants_and_dishes_listing/bindings/restaurants_and_dishes_listing_binding.dart';
import '../modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FOOD,
      page: () => const FoodView(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: _Paths.RESTAURANTS_AND_DISHES_LISTING,
      page: () =>  RestaurantsAndDishesListingView(),
      binding: RestaurantsAndDishesListingBinding(),
    ),
  ];
}