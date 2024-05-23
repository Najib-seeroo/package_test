import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/authentication/model/create_user_response.dart';

import '../../services/api_service.dart';
import 'authentication_service.dart';
import 'model/authentication_response.dart';


class AuthRepository implements AuthService {
  ApiService apiService = Get.find();

  @override
  Future<AuthenticationResponse> authenticate(Map<String, dynamic>? params) async {
    AuthenticationResponse authenticationResponse;
    Response response = await apiService.reqst(url: 'auth/auth-verification', params: params);
    debugPrint(response.statusCode.toString());
    try {
      authenticationResponse = AuthenticationResponse.fromJson(response.body);
      debugPrint("inside repo ${authenticationResponse.status}");
      return authenticationResponse;
    } catch (e,s) {
      debugPrint(s.toString());
      return AuthenticationResponse(
          message: "Server Error", status: 401);
    }
  }

  @override
  Future<CreateUserResponse> createUser(Map<String, dynamic>? params) async {
    CreateUserResponse createUserResponse;
    Response response = await apiService.reqst(url: 'sdk/create-users', params: params);
    debugPrint(response.statusCode.toString());
    try {
      createUserResponse = CreateUserResponse.fromJson(response.body);
      debugPrint("inside repo ${createUserResponse.status}");
      return createUserResponse;
    } catch (e,s) {
      debugPrint(s.toString());
      return CreateUserResponse(
          message: "Server Error", status: 401);
    }
  }




}
