import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../model/refresh_token_model.dart';
import '../storage/storage.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class ApiService extends GetConnect implements GetxService {
  final String baseUrl;
  late Map<String, String> _headers;

  AppStorage storage = Get.put(AppStorage());
  int nullResCount = 0;
  bool showingExpiryDialog = false;

  ApiService({required this.baseUrl}) {
    _headers = {
      'Content-Type': 'application/json',
    };
  }

  @override
  void onInit() {
    timeout = Duration(minutes: 1);
    maxAuthRetries = 3;
  }

  Future<Response> reqst(
      {required String url,
      Method? method = Method.POST,
      Map<String, dynamic>? params}) async {
    debugPrint("base url $baseUrl");
    Response response;
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        debugPrint("connection $result");

        if (storage.isAuthenticated()) {
          updateHeaders();
        }

        if (method == Method.POST) {
          response = await post(url, params, headers: _headers);
        } else if (method == Method.DELETE) {
          response = await delete(url, headers: _headers);
        } else if (method == Method.PATCH) {
          response = await patch(url, params, headers: _headers);
        } else {
          response = await get(url, headers: _headers);
        }
        debugPrint("request url : ${baseUrl}$url");
        debugPrint("request : $params");
        debugPrint("headers : $_headers");
        debugPrint("status code :${response.statusCode}  ulr : ${url}");
        log("response : ${response.body}");
        if (response.body == null && nullResCount < 2) {
          nullResCount++;
          return reqst(url: url, method: method, params: params);
        } else {
          if (response.statusCode == 200 || response.statusCode == 201) {
            nullResCount = 0;
            return response;
          } else if (response.statusCode == 401) {
            //  throw Exception("Something Went Wrong");
            return await refreshTokenApi(url, params, method);
          }
          // else if (response.statusCode == 403) {
          //   return await refreshTokenApi(url, params, method);
          //
          // }
          else if (response.statusCode == 500) {
            throw Exception("Server Error");
          } else {
            throw Exception("Something Went Wrong");
          }
        }
      } else {
        throw Exception("No Internet Connection");
      }
    } on SocketException catch (e) {
      log("Error = $e");
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } catch (e) {
      return Response(
        body: {
          'status': false,
          'message': e.toString().replaceAll("Exception:", "")
        },
        statusCode: 500,
      );
    }
  }

  updateHeaders() {
    _headers['Authorization'] = "Bearer ${storage.getAccessToken()}";
  }

  Future<Response> refreshTokenApi(
      String path, Map<String, dynamic>? reqBody, Method? method) async {
    late Response res;
    Map<String, dynamic> body = {
      "refresh_token": storage.getRefreshToken(),
    };
    try {
      debugPrint('---------  Refresh Token  ---------');
      debugPrint('refreshTokenBody :$body');
      res = await reqst(url: 'auth/auth-refresh', params: body);
      debugPrint('refreshTokenStatusCode :${res.statusCode}');
    } catch (e) {
      debugPrint('refreshTokenError');
      return showingExpiryDialog
          ? Response()
          : Response(
              body: {'status': false, 'message': "Server Error"},
              statusCode: 500,
            );
    }

    if (res.statusCode == 200) {
      RefreshTokenModel model = RefreshTokenModel.fromJson(res.body);
      storage.writeAccessToken(model.data?.accessToken ?? "");
      storage.writeRefreshToken(model.data?.refreshToken ?? "");
      updateHeaders();

      if (method == Method.GET) {
        late Response res;
        try {
          res = await reqst(url: path, method: Method.GET);
          debugPrint('status code : ${res.statusCode}');
        } catch (e) {
          return Response(
            body: {'status': false, 'message': "Server Errorr"},
            statusCode: 500,
          );
        }
        return res;
      } else {
        late Response res;
        try {
          res = await reqst(
            url: path,
            params: reqBody,
          );
          debugPrint('status code : ${res.statusCode}');
        } catch (e) {
          return Response(
            body: {'status': false, 'message': "Server Error"},
            statusCode: 500,
          );
        }
        return res;
      }
    }
    return Response(
      body: {'status': false, 'message': "Server Error"},
      statusCode: 500,
    );
  }
}
