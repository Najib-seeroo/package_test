import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../controllers/restaurants_details_controller.dart';

class RestaurantsDetailsView extends GetView<RestaurantsDetailsController> {
  const RestaurantsDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Imperio Restaurant',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const BannerAndRatingWidget(),
                const SizedBox(
                  height: 20,
                ),
                const SearchWidget(),
                const SizedBox(
                  height: 20,
                ),
                const ChipWidget(),
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DishCard(
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: 5)
              ],
            ),
          ),
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
                  SvgPicture.asset(
                    chipImages[index],
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
  const SearchWidget({super.key});

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
                hintText: "Search in Imperio Restaurant",
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
  const BannerCarousal({super.key});

  @override
  State<BannerCarousal> createState() => _BannerCarousalState();
}

class _BannerCarousalState extends State<BannerCarousal> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          child: CarouselSlider(
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
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      "packages/mynewpackage/lib/assets/images/banner.jpg",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              );
            }).toList(),
          ),
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Column(
            children: [
              const BannerCarousal(),
              const Padding(
                padding:
                    EdgeInsets.only(left: 150, right: 10, top: 10, bottom: 5),
                child: Text(
                  "This popular, unassuming eatery dishes up an array of traditional Indian fare.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color.fromRGBO(69, 84, 97, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 150, right: 10, top: 5, bottom: 10),
                child: Row(
                  children: [
                    Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
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
                          const Text(
                            "4.1(10k+)",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      label: const Text(
                        "1.6km",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 160,
            left: 20,
            child: Image.asset(
                "packages/mynewpackage/lib/assets/images/restaurant-logo.png"),
          ),
        ],
      ),
    );
  }
}
