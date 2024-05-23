import 'dart:convert';
/// status : 200
/// message : "Data retrieve successfully."
/// data : {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJob3N0X2lkIjoiNjY0NzA1MzQwODIwNTAyYWUzOTlkOWI4IiwidGltZVpvbmUiOiJBc2lhL0tvbGthdGEiLCJpYXQiOjE3MTYzNzA0NzgsImV4cCI6MTcxNjM3MTM3OH0.SAfokSQO0r4UJCO4JWN7cApDu-G1gP24FIItlAOpyxI","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJob3N0X2lkIjoiNjY0NzA1MzQwODIwNTAyYWUzOTlkOWI4IiwidGltZVpvbmUiOiJBc2lhL0tvbGthdGEiLCJpYXQiOjE3MTYzNzA0NzgsImV4cCI6MTcxNjk3NTI3OH0.bB9cvwehbTR3J7g9EgcnOCcGrUIeGp3hRYKLzlwNuHY","accessTokenExpiry":"2024-05-22T10:34:38.129Z","refreshTokenExpiry":"2024-05-23T09:34:38.129Z"}

AuthenticationResponse authenticationResponseFromJson(String str) => AuthenticationResponse.fromJson(json.decode(str));
String authenticationResponseToJson(AuthenticationResponse data) => json.encode(data.toJson());
class AuthenticationResponse {
  AuthenticationResponse({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AuthenticationResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
AuthenticationResponse copyWith({  num? status,
  String? message,
  Data? data,
}) => AuthenticationResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJob3N0X2lkIjoiNjY0NzA1MzQwODIwNTAyYWUzOTlkOWI4IiwidGltZVpvbmUiOiJBc2lhL0tvbGthdGEiLCJpYXQiOjE3MTYzNzA0NzgsImV4cCI6MTcxNjM3MTM3OH0.SAfokSQO0r4UJCO4JWN7cApDu-G1gP24FIItlAOpyxI"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJob3N0X2lkIjoiNjY0NzA1MzQwODIwNTAyYWUzOTlkOWI4IiwidGltZVpvbmUiOiJBc2lhL0tvbGthdGEiLCJpYXQiOjE3MTYzNzA0NzgsImV4cCI6MTcxNjk3NTI3OH0.bB9cvwehbTR3J7g9EgcnOCcGrUIeGp3hRYKLzlwNuHY"
/// accessTokenExpiry : "2024-05-22T10:34:38.129Z"
/// refreshTokenExpiry : "2024-05-23T09:34:38.129Z"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? accessToken, 
      String? refreshToken, 
      String? accessTokenExpiry, 
      String? refreshTokenExpiry,}){
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _accessTokenExpiry = accessTokenExpiry;
    _refreshTokenExpiry = refreshTokenExpiry;
}

  Data.fromJson(dynamic json) {
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
    _accessTokenExpiry = json['accessTokenExpiry'];
    _refreshTokenExpiry = json['refreshTokenExpiry'];
  }
  String? _accessToken;
  String? _refreshToken;
  String? _accessTokenExpiry;
  String? _refreshTokenExpiry;
Data copyWith({  String? accessToken,
  String? refreshToken,
  String? accessTokenExpiry,
  String? refreshTokenExpiry,
}) => Data(  accessToken: accessToken ?? _accessToken,
  refreshToken: refreshToken ?? _refreshToken,
  accessTokenExpiry: accessTokenExpiry ?? _accessTokenExpiry,
  refreshTokenExpiry: refreshTokenExpiry ?? _refreshTokenExpiry,
);
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get accessTokenExpiry => _accessTokenExpiry;
  String? get refreshTokenExpiry => _refreshTokenExpiry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    map['accessTokenExpiry'] = _accessTokenExpiry;
    map['refreshTokenExpiry'] = _refreshTokenExpiry;
    return map;
  }

}