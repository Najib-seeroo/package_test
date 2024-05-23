import 'dart:convert';
/// status : 200
/// message : "Data retrieve successfully."
/// data : {"_id":"664705340820502ae399d9b8","ServiceCategories":[{"_id":"6646f17c6538869d3399af45","category_name":"Food","category_code":"FD","status":1,"images":[{"primary":"https://icons8.com/icon/5w3XGkaXrcaV/edible"}]},{"_id":"6646f2196538869d3399af46","category_name":"Cabs","category_code":"BR","status":1,"images":[{"primary":"https://icons8.com/icon/111270/car"}]},{"_id":"6646f22b6538869d3399af47","category_name":"Salon Services","category_code":"SS","status":1,"images":[{"primary":"https://icons8.com/icon/pwpz1tqVnCQy/ticket"}]},{"_id":"6646f24e6538869d3399af48","category_name":"Home Services","category_code":"BS","status":1,"images":[{"primary":" https://icons8.com/icon/2Buj9vnf__qe/barbershop"}]},{"_id":"664c67f8f56c737334730ff3","category_name":"Gifts","category_code":"GS","status":1,"images":[{"primary":" https://icons8.com/icon/2Buj9vnf__qe/barbershop"}]},{"_id":"664c680ef56c737334730ff4","category_name":"Furniture","category_code":"FE","status":1,"images":[{"primary":" https://icons8.com/icon/2Buj9vnf__qe/barbershop"}]},{"_id":"664c683ef56c737334730ff6","category_name":"Grocery","category_code":"GY","status":1,"images":[{"primary":" https://icons8.com/icon/2Buj9vnf__qe/barbershop"}]}]}

ServiceCategoryResponse serviceCategoryResponseFromJson(String str) => ServiceCategoryResponse.fromJson(json.decode(str));
String serviceCategoryResponseToJson(ServiceCategoryResponse data) => json.encode(data.toJson());
class ServiceCategoryResponse {
  ServiceCategoryResponse({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ServiceCategoryResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
ServiceCategoryResponse copyWith({  num? status,
  String? message,
  Data? data,
}) => ServiceCategoryResponse(  status: status ?? _status,
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

/// _id : "664705340820502ae399d9b8"
/// ServiceCategories : [{"_id":"6646f17c6538869d3399af45","category_name":"Food","category_code":"FD","status":1,"images":[{"primary":"https://icons8.com/icon/5w3XGkaXrcaV/edible"}]},{"_id":"6646f2196538869d3399af46","category_name":"Cabs","category_code":"BR","status":1,"images":[{"primary":"https://icons8.com/icon/111270/car"}]},{"_id":"6646f22b6538869d3399af47","category_name":"Salon Services","category_code":"SS","status":1,"images":[{"primary":"https://icons8.com/icon/pwpz1tqVnCQy/ticket"}]},{"_id":"6646f24e6538869d3399af48","category_name":"Home Services","category_code":"BS","status":1,"images":[{"primary":" https://icons8.com/icon/2Buj9vnf__qe/barbershop"}]},{"_id":"664c67f8f56c737334730ff3","category_name":"Gifts","category_code":"GS","status":1,"images":[{"primary":" https://icons8.com/icon/2Buj9vnf__qe/barbershop"}]},{"_id":"664c680ef56c737334730ff4","category_name":"Furniture","category_code":"FE","status":1,"images":[{"primary":" https://icons8.com/icon/2Buj9vnf__qe/barbershop"}]},{"_id":"664c683ef56c737334730ff6","category_name":"Grocery","category_code":"GY","status":1,"images":[{"primary":" https://icons8.com/icon/2Buj9vnf__qe/barbershop"}]}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      List<ServiceCategories>? serviceCategories,}){
    _id = id;
    _serviceCategories = serviceCategories;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['ServiceCategories'] != null) {
      _serviceCategories = [];
      json['ServiceCategories'].forEach((v) {
        _serviceCategories?.add(ServiceCategories.fromJson(v));
      });
    }
  }
  String? _id;
  List<ServiceCategories>? _serviceCategories;
Data copyWith({  String? id,
  List<ServiceCategories>? serviceCategories,
}) => Data(  id: id ?? _id,
  serviceCategories: serviceCategories ?? _serviceCategories,
);
  String? get id => _id;
  List<ServiceCategories>? get serviceCategories => _serviceCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_serviceCategories != null) {
      map['ServiceCategories'] = _serviceCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6646f17c6538869d3399af45"
/// category_name : "Food"
/// category_code : "FD"
/// status : 1
/// images : [{"primary":"https://icons8.com/icon/5w3XGkaXrcaV/edible"}]

ServiceCategories serviceCategoriesFromJson(String str) => ServiceCategories.fromJson(json.decode(str));
String serviceCategoriesToJson(ServiceCategories data) => json.encode(data.toJson());
class ServiceCategories {
  ServiceCategories({
      String? id, 
      String? categoryName, 
      String? categoryCode, 
      num? status, 
      List<Images>? images,}){
    _id = id;
    _categoryName = categoryName;
    _categoryCode = categoryCode;
    _status = status;
    _images = images;
}

  ServiceCategories.fromJson(dynamic json) {
    _id = json['_id'];
    _categoryName = json['category_name'];
    _categoryCode = json['category_code'];
    _status = json['status'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
  }
  String? _id;
  String? _categoryName;
  String? _categoryCode;
  num? _status;
  List<Images>? _images;
ServiceCategories copyWith({  String? id,
  String? categoryName,
  String? categoryCode,
  num? status,
  List<Images>? images,
}) => ServiceCategories(  id: id ?? _id,
  categoryName: categoryName ?? _categoryName,
  categoryCode: categoryCode ?? _categoryCode,
  status: status ?? _status,
  images: images ?? _images,
);
  String? get id => _id;
  String? get categoryName => _categoryName;
  String? get categoryCode => _categoryCode;
  num? get status => _status;
  List<Images>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['category_name'] = _categoryName;
    map['category_code'] = _categoryCode;
    map['status'] = _status;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// primary : "https://icons8.com/icon/5w3XGkaXrcaV/edible"

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
String imagesToJson(Images data) => json.encode(data.toJson());
class Images {
  Images({
      String? primary,}){
    _primary = primary;
}

  Images.fromJson(dynamic json) {
    _primary = json['primary'];
  }
  String? _primary;
Images copyWith({  String? primary,
}) => Images(  primary: primary ?? _primary,
);
  String? get primary => _primary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['primary'] = _primary;
    return map;
  }

}