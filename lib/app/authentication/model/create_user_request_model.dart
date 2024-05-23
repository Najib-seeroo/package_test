import 'dart:convert';
/// phone_number : "23232323"
/// phone_code : "232"

CreateUserRequestModel createUserRequestModelFromJson(String str) => CreateUserRequestModel.fromJson(json.decode(str));
String createUserRequestModelToJson(CreateUserRequestModel data) => json.encode(data.toJson());
class CreateUserRequestModel {
  CreateUserRequestModel({
      String? phoneNumber, 
      String? phoneCode,}){
    _phoneNumber = phoneNumber;
    _phoneCode = phoneCode;
}

  CreateUserRequestModel.fromJson(dynamic json) {
    _phoneNumber = json['phone_number'];
    _phoneCode = json['phone_code'];
  }
  String? _phoneNumber;
  String? _phoneCode;
CreateUserRequestModel copyWith({  String? phoneNumber,
  String? phoneCode,
}) => CreateUserRequestModel(  phoneNumber: phoneNumber ?? _phoneNumber,
  phoneCode: phoneCode ?? _phoneCode,
);
  String? get phoneNumber => _phoneNumber;
  String? get phoneCode => _phoneCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_number'] = _phoneNumber;
    map['phone_code'] = _phoneCode;
    return map;
  }

}