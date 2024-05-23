import 'dart:convert';
/// status : 200
/// message : "Data retrieve successfully."
/// data : {"_id":"664dbc5f402b694d6bb8c9d9","phone_number":"23232323","__v":0,"host_id":"664705340820502ae399d9b8","phone_code":"232"}

CreateUserResponse createUserResponseFromJson(String str) => CreateUserResponse.fromJson(json.decode(str));
String createUserResponseToJson(CreateUserResponse data) => json.encode(data.toJson());
class CreateUserResponse {
  CreateUserResponse({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CreateUserResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
CreateUserResponse copyWith({  num? status,
  String? message,
  Data? data,
}) => CreateUserResponse(  status: status ?? _status,
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

/// _id : "664dbc5f402b694d6bb8c9d9"
/// phone_number : "23232323"
/// __v : 0
/// host_id : "664705340820502ae399d9b8"
/// phone_code : "232"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? phoneNumber, 
      num? v, 
      String? hostId, 
      String? phoneCode,}){
    _id = id;
    _phoneNumber = phoneNumber;
    _v = v;
    _hostId = hostId;
    _phoneCode = phoneCode;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _phoneNumber = json['phone_number'];
    _v = json['__v'];
    _hostId = json['host_id'];
    _phoneCode = json['phone_code'];
  }
  String? _id;
  String? _phoneNumber;
  num? _v;
  String? _hostId;
  String? _phoneCode;
Data copyWith({  String? id,
  String? phoneNumber,
  num? v,
  String? hostId,
  String? phoneCode,
}) => Data(  id: id ?? _id,
  phoneNumber: phoneNumber ?? _phoneNumber,
  v: v ?? _v,
  hostId: hostId ?? _hostId,
  phoneCode: phoneCode ?? _phoneCode,
);
  String? get id => _id;
  String? get phoneNumber => _phoneNumber;
  num? get v => _v;
  String? get hostId => _hostId;
  String? get phoneCode => _phoneCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['phone_number'] = _phoneNumber;
    map['__v'] = _v;
    map['host_id'] = _hostId;
    map['phone_code'] = _phoneCode;
    return map;
  }

}