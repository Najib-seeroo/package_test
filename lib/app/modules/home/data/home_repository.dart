import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/data/home_service.dart';

import '../../../../services/api_service.dart';
import 'models/service_category_response.dart';




class HomeRepository implements HomeService {
  ApiService apiService = Get.find();

  @override
  Future<ServiceCategoryResponse> getServiceList() async {
    ServiceCategoryResponse serviceCategoryResponse;
    Response response = await apiService.reqst(url: 'sdk/get-host-servicecategories',method: Method.GET);
    debugPrint(response.statusCode.toString());
    try {
      serviceCategoryResponse = ServiceCategoryResponse.fromJson(response.body);
      debugPrint("inside repo ${serviceCategoryResponse.status}");
      return serviceCategoryResponse;
    } catch (e,s) {
      debugPrint(s.toString());
      return ServiceCategoryResponse(
          message: "Server Error", status: 401);
    }
  }






}
