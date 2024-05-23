import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mynewpackage/app/authentication/authentication_repo.dart';
import 'package:mynewpackage/app/authentication/model/authentication_request_model.dart';
import 'package:mynewpackage/app/authentication/model/create_user_request_model.dart';
import 'package:mynewpackage/app/modules/home/data/home_repository.dart';
import 'package:mynewpackage/storage/storage.dart';

import '../../../../app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../../widgets/common_Image_view.dart';
import '../data/models/service_category_response.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List gridItemsName = [
    "Food",
    "Cabs",
    "Salon Services",
    "Home Services",
    "Gifts",
    "Furniture",
    "Courier",
    "Grocery",
    "Others"
  ];
  List imagesItem = [
    Assets.iconsFood,
    Assets.iconsCab,
    Assets.iconsSalonService,
    Assets.iconsHomeService,
    Assets.iconsGifts,
    Assets.iconsFurniture,
    Assets.iconsCourier,
    Assets.iconsGrocery,
    Assets.iconsOthers
  ];
  List addressTypeImage = [Assets.iconsHomeIcon, Assets.iconsOffice];
  List addressHeading = ["Home", "Office"];
  List addressDescription = [
    "67/8, 4th cross Road, Lavella Road,  Bengaluru,Karnataka 560001, India",
    "No. 63, 1st Floor, 14th Cross, 9th Main Road,Indiranagar, Bengaluru, Karnataka 560038, India"
  ];
  RxString address = '"No. 63, 1st Floor, 14th Cross, 9th Main Road,Indiranagar, Bengaluru, Karnataka 560038, India"'.obs;
  RxBool isLoading = false.obs;
  AppStorage storage = AppStorage();
  AuthRepository authRepository = Get.put(AuthRepository());
  HomeRepository homeRepository = Get.put(HomeRepository());
   RxList<ServiceCategories> serviceList = List<ServiceCategories>.empty(growable: true).obs;





  @override
  void onInit() {
    debugPrint("hi");
    super.onInit();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showAddressSelectionBottomSheet(context: Get.context!);
    // });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void showAddressSelectionBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Your Delivery Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.add_circle_outline, color: AppColors.primaryColor,),
                  const SizedBox(width: 10,),
                  Text("Add New Address",
                    style: TextStyle(color: AppColors.primaryColor),),

                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Saved Address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: addressTypeImage.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          address.value = addressDescription[index];
                          debugPrint("value ${address.value}");
                          Get.back();
                        },
                        child: Container(
                          color: AppColors.backgroundColor,
                          child: ListTile(
                            leading: CommonImageView(
                              svgPath: "packages/mynewpackage/${addressTypeImage[index]}",),
                            title: Text(addressHeading[index],
                              style: const TextStyle(fontSize: 16),),
                            subtitle: Text(addressDescription[index],
                              style: (TextStyle(color: AppColors.textColor)),),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  void authenticate({required String clientId,required String clientSecrete}) async {
    isLoading(true);
    debugPrint("before api call${isLoading.value}");


    AuthenticationRequestModel requestModel = AuthenticationRequestModel(
        clientId:clientId, clientSecrete:clientSecrete
    );

    var result = await InternetConnectionChecker().hasConnection;

    if(result == true){
      await authRepository.authenticate(requestModel.toJson()).then((value) {
        if (value.status == 200) {
          isLoading(false);

          debugPrint("after success${isLoading.value}");


          debugPrint("authenticated");
          debugPrint("${value.message}");
          debugPrint("token${value.data?.refreshToken}");
          storage.writeAccessToken(value.data?.accessToken ?? "");
          debugPrint("access token ${storage.getAccessToken()}");
          storage.writeRefreshToken(value.data?.refreshToken ?? "");
          storage.writeIsAuthenticated(true);
          createUser();
          getServices();

        } else {
          debugPrint("after failure${value.message}");

          ScaffoldMessenger.of(Get.context!).showSnackBar(
              SnackBar(content: Text("${value.message}",), backgroundColor: Colors.red,));
        }
      });
    }else{
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("No Internet",), backgroundColor: Colors.red,));
    }
  }

  void createUser() async {
    isLoading(true);
    debugPrint("before api call${isLoading.value}");

    CreateUserRequestModel requestModel = CreateUserRequestModel(
      phoneNumber: "21341232",phoneCode: "12234"
    );



   await authRepository.createUser(requestModel.toJson()).then((value) {
      if (value.status == 200) {
        isLoading(false);

        debugPrint("after success${isLoading.value}");


        debugPrint("authenticated");
        debugPrint("${value.message}");
        storage.writeUserId(value.data?.id ?? "");
      } else {

        debugPrint("after failure${value.message}");

        ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text(value.message.toString(),),backgroundColor: Colors.red,));
      }
    });
  }


  void getServices() async {
    isLoading(true);
    await homeRepository.getServiceList().then((value) {
      if (value.data?.serviceCategories != [] && (value.status == 200)) {

        serviceList.addAll(value.data?.serviceCategories ?? []);
        debugPrint("list service ${serviceList.first.categoryName}");
        isLoading(false);
      } else {
        isLoading(false);
        getServices();
      }
    });
  }



}
