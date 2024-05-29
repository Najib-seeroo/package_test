import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app/modules/restaurants_details/controllers/restaurants_details_controller.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/widgets/common_Image_view.dart';
import 'package:mynewpackage/widgets/loading_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/utility.dart';

class RestaurantsDetailsView extends StatefulWidget {
  const RestaurantsDetailsView({super.key, required this.restaurantId, required this.distance});

  final String restaurantId;
  final num distance;

  @override
  State<RestaurantsDetailsView> createState() => _RestaurantsDetailsViewState();
}

class _RestaurantsDetailsViewState extends State<RestaurantsDetailsView> {
  RestaurantsDetailsController restaurantsDetailsController =
      Get.put(RestaurantsDetailsController());

  @override
  void initState() {
    restaurantsDetailsController.getRestaurantdetails(
        restaurantId: widget.restaurantId, initial: true);
    Get.lazyPut(() => RestaurantsDetailsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Obx(() {
          return restaurantsDetailsController.isLoading.value? const Center(child: CircularProgressIndicator(color: Colors.transparent,)):Text(
            restaurantsDetailsController
                    .restaurantDetails.first.restaurantDetails?.first.name ??
                '',
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
          );
        }),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: LoadingView(
        isAsyncCall: restaurantsDetailsController.isLoading,
        showBackGroundData: false,
        authenticated: true.obs,
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            return restaurantsDetailsController.onScrollOngoing(scrollInfo,
                restaurantId: widget.restaurantId);
          },
          child:  SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                             BannerAndRatingWidget(controller: restaurantsDetailsController, distance: widget.distance,),
                            const SizedBox(
                              height: 20,
                            ),
                             SearchWidget(controller: restaurantsDetailsController,),
                            const SizedBox(
                              height: 20,
                            ),
                            const ChipWidget(),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return DishCard(
                                    restaurant: restaurantsDetailsController
                                        .restaurantDetails[index],
                                    index: index,
                                    isDishes: false,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: restaurantsDetailsController
                                    .restaurantDetails.length,
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  )
        ),
      ),
    );
  }
}

class ChipWidget extends StatefulWidget {
  const ChipWidget({
    super.key,
  });

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<String> chipTitles = [
      "Veg",
      "Egg",
      "Non Veg",
      "Rating",
      "Recommended"
    ];
    List<String> chipImages = [
      "packages/mynewpackage/lib/assets/icons/veg.svg",
      "packages/mynewpackage/lib/assets/icons/egg.svg",
      "packages/mynewpackage/lib/assets/icons/non-veg.svg",
      "packages/mynewpackage/lib/assets/icons/Star.svg",
      ""
    ];
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Chip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: const BorderSide(color: Colors.grey),
              ),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonImageView(
                    svgPath:chipImages[index],
                    color: selectedIndex == index ? Colors.white : null,
                  ),

                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    chipTitles[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          selectedIndex == index ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              backgroundColor:
                  selectedIndex == index ? AppColors.primaryColor : null,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemCount: 5,
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.controller});

  final RestaurantsDetailsController controller;

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  TextEditingController searchController = TextEditingController();
  Color micBackground = const Color(0xff86EAAA);
  double micSize = 60.0;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    log("Started Listening", name: "Voice");
    await _speechToText.listen(
      onResult: _onSpeechResult,
      onSoundLevelChange: _onSoundLevelChange,
    );
    setState(() {});
  }

  void _stopListening() async {
    log("Stopped Listening", name: "Voice");
    await _speechToText.stop();
    searchController.text = _speechToText.isListening
        ? _lastWords
        : _speechEnabled
            ? 'Tap the microphone to start listening...'
            : 'Speech not available';
    setState(() {
      micSize = 60.0;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      log("Speech result = ${result.recognizedWords}", name: "Voice");
      _lastWords = result.recognizedWords;
      searchController.text = result.recognizedWords;
      micSize = 60.0;
    });
  }

  void _onSoundLevelChange(double level) {
    setState(() {
      log("Level = $level", name: "Voice");
      if (level < 0) {
        micSize = 60.0;
      } else {
        micSize = 60.0 + level * 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
      ),
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search in ${ widget.controller
                    .restaurantDetails.firstOrNull?.branchName}",
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6C7B88),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    "packages/mynewpackage/lib/assets/icons/search-icon.svg",
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              searchController.text = '';
              _speechToText.isNotListening
                  ? _startListening()
                  : _stopListening();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOutCubicEmphasized,
              height: 60,
              width: micSize,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                color: micBackground,
              ),
              child: SvgPicture.asset(
                "packages/mynewpackage/lib/assets/icons/mic-icon.svg",
                height: 20,
                width: 13,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerCarousal extends StatefulWidget {
  const BannerCarousal({super.key,required this.controller});

  final RestaurantsDetailsController controller;

  @override
  State<BannerCarousal> createState() => _BannerCarousalState();
}

class _BannerCarousalState extends State<BannerCarousal> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            // height: MediaQuery.of(context).size.height * 0.29,
            viewportFraction: 1.2,
            aspectRatio: 16 / 8.5,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CommonImageView(
                    width: MediaQuery.of(context).size.width*.9,
                    url:
                    widget.controller.restaurantDetails.first.bannerImages?.first.image,
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 5,
                effect: const WormEffect(
                  activeDotColor: Color(0xFF184568),
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BannerAndRatingWidget extends StatelessWidget {
  const BannerAndRatingWidget({
    super.key,required this.controller, required this.distance
  });

  final RestaurantsDetailsController controller;
  final num distance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: [
          Column(
            children: [
               BannerCarousal(controller: controller,),
              Padding(
                padding: const EdgeInsets.only(
                    left: 120, right: 10, top: 10, bottom: 15),
                child: Obx(
                 () {
                    return Column(
                      children: [
                         InkWell(
                           onTap: (){
                             controller.showMore.value = !controller.showMore.value;
                           },
                           child: Wrap(
                             children: [
                               Text(
                                controller.restaurantDetails.first.images?.first.description ?? "",
                                maxLines:controller.showMore.value ? 10: 2,
                                style:  TextStyle(
                                  overflow:!controller.showMore.value ? TextOverflow.ellipsis:null,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(69, 84, 97, 1),
                                ),
                                                   ),
                                Text(!controller.showMore.value?"Read More":"Read Less",style: TextStyle(color: AppColors.primaryColor),)
                             ],
                           ),
                         ),
                        Row(
                          children: [
                            Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                      "packages/mynewpackage/lib/assets/icons/Star.svg"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                   Text(
                                    "${controller.restaurantDetails.first.rating}(${Utility.countConverter(controller.restaurantDetails.first.totalRating)})",
                                    style: TextStyle(
                                        fontSize: 10, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              label:  Text(
                                "${distance.toStringAsFixed(1)} km",
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                ),
              ),
            ],
          ),
          Positioned(
            top: 180,
            left: 10,
            child: ClipOval(
              child: Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    child: Image.network(
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        "${controller.restaurantDetails.first.logo}"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
