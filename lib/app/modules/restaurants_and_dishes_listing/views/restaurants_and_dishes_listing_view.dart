import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_details/views/restaurants_details_view.dart';

import '../../../../app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../../widgets/common_Image_view.dart';
import '../controllers/restaurants_and_dishes_listing_controller.dart';

class RestaurantsAndDishesListingView
    extends GetView<RestaurantsAndDishesListingController> {
  RestaurantsAndDishesListingView({super.key});

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: InkWell(
            onTap: () {
              homeController.showAddressSelectionBottomSheet(context: context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Your Location',
                      style: TextStyle(
                          fontSize: 14, color: AppColors.textLightColor),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 14,
                    )
                  ],
                ),
                Obx(() {
                  return Row(
                    children: [
                      CommonImageView(
                          svgPath:
                              "packages/mynewpackage/${Assets.iconsLocation}"),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Text(homeController.address.value,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis))),
                    ],
                  );
                }),
              ],
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            labelStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            tabs: const <Widget>[
              Tab(
                text: "Restaurants",
              ),
              Tab(
                text: "Dishes",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            RestaurantList(controller: controller),
            Column(
              children: [
                Row(
                  children: List.generate(
                    controller.filterImages.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          controller.selectedCategory.value = index;
                        },
                        child: Obx(() {
                          return Container(
                            height: 35,
                            width: 85,
                            decoration: BoxDecoration(
                              color: controller.selectedCategory.value == index
                                  ? AppColors.primaryColor
                                  : AppColors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40),
                              ),
                              border: Border.all(
                                color: AppColors.borderColor,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  controller.selectedCategory.value == index
                                      ? CommonImageView(
                                          svgPath:
                                              "packages/mynewpackage/${controller.filterImages[index]}",
                                          color: AppColors.white,
                                        )
                                      : CommonImageView(
                                          svgPath:
                                              "packages/mynewpackage/${controller.filterImages[index]}"),
                                  Text(
                                    controller.filters[index],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            controller.selectedCategory.value ==
                                                    index
                                                ? AppColors.white
                                                : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.vegNames.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
                          child: DishCard(
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DishCard extends StatefulWidget {
  final int index;
  const DishCard({
    super.key,
    required this.index,
  });

  @override
  State<DishCard> createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  int _count = 0;

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  void _decrementCount() {
    setState(() {
      if (_count > 0) _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Card(
        color: AppColors.white,
        surfaceTintColor: AppColors.white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: CommonImageView(
                    imagePath:
                        "packages/mynewpackage/${Assets.imagesEggChilly}",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Egg Friend Rice",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text("₹200"),
                      Chip(
                        label: Row(
                          children: [
                            CommonImageView(
                              svgPath:
                                  "packages/mynewpackage/${Assets.iconsStar}",
                            ),
                            const Text(
                              "4.5(7k+)",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: BorderSide(color: AppColors.borderColor),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CommonImageView(
                                  svgPath:
                                      "packages/mynewpackage/${Assets.iconsShopIcon}",
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Food Hunt",
                                  style: TextStyle(
                                      color: AppColors.textLightColor),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_count == 0)
                                  IconButton(
                                    icon: CommonImageView(
                                      svgPath:
                                          "packages/mynewpackage/${Assets.iconsAddIcon}",
                                    ),
                                    onPressed: _incrementCount,
                                  ),
                                if (_count > 0) ...[
                                  // Chip(
                                  //   shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(50.0),
                                  //     side:
                                  //         const BorderSide(color: Colors.grey),
                                  //   ),
                                  //   backgroundColor: AppColors.primaryColor,
                                  //   label: ,
                                  // ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: _incrementCount,
                                            child: const Icon(
                                                size: 20,
                                                Icons.add,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '$_count',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          InkWell(
                                            onTap: _decrementCount,
                                            child: const Icon(
                                                size: 20,
                                                Icons.remove,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    super.key,
    required this.controller,
  });

  final RestaurantsAndDishesListingController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.restaurantNames.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Get.to(const RestaurantsDetailsView());
            },
            child: Container(
                color: AppColors.backgroundColor,
                child: Card(
                  color: AppColors.white,
                  surfaceTintColor: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: controller.hasOffer[index].value == true
                            ? Stack(children: [
                                controller.isUnavailable[index].value == true
                                    ? ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 4.0, sigmaY: 4.0),
                                        child: Image.asset(
                                          "packages/mynewpackage/${controller.restaurantImages[index]}",
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : CommonImageView(
                                        imagePath:
                                            "packages/mynewpackage/${controller.restaurantImages[index]}",
                                      ),
                                controller.isUnavailable[index].value == false
                                    ? CommonImageView(
                                        svgPath:
                                            "packages/mynewpackage/${Assets.iconsOffer}",
                                      )
                                    : ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 4.0, sigmaY: 4.0),
                                        child: SvgPicture.asset(
                                          "packages/mynewpackage/${Assets.iconsOffer}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "30% OFF",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white),
                                  ),
                                ),
                                Positioned(
                                    top: 30,
                                    left: 5,
                                    child: Text("Upto ₹75",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.white))),
                              ])
                            : controller.isUnavailable[index].value == false
                                ? CommonImageView(
                                    imagePath:
                                        "packages/mynewpackage/${controller.restaurantImages[index]}")
                                : ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                        sigmaX: 4.0, sigmaY: 4.0),
                                    child: Image.asset(
                                      "packages/mynewpackage/${controller.restaurantImages[index]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text(
                          "${controller.restaurantNames[index]}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Chip(
                              label: Row(
                                children: [
                                  CommonImageView(
                                      svgPath:
                                          "packages/mynewpackage/${Assets.iconsStar}"),
                                  Text("${controller.ratings[index]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              side: BorderSide(color: AppColors.borderColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Chip(
                              label: Text(
                                "${controller.kilometers[index]} km",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side:
                                      BorderSide(color: AppColors.borderColor)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          "${controller.descriptions[index]}",
                          style: TextStyle(
                              fontSize: 14, color: AppColors.textColor),
                        ),
                      ),
                      controller.isUnavailable[index].value == true
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text(
                                "Currently Unavailable",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
