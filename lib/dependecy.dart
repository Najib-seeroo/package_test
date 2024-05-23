import 'package:get/get.dart';
import 'package:mynewpackage/services/api_service.dart';
import 'package:mynewpackage/services/config.dart';
import 'package:mynewpackage/storage/storage.dart';

import 'app/authentication/authentication_repo.dart';
import 'app/authentication/authentication_service.dart';
import 'app/modules/home/controllers/home_controller.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut<ApiService>(
          () => ApiService(
          baseUrl: ConfigEnvironments.getEnvironments()['url'] ?? ""),
    );

    Get.lazyPut<HomeController>(
          () => HomeController(),
    );


    Get.lazyPut<AuthService>(() => AuthRepository(), fenix: true);
    Get.lazyPut<ApiService>(() => ApiService(baseUrl: ""), fenix: true);
    Get.lazyPut<AppStorage>(() => AppStorage(), fenix: true);

  }
}
