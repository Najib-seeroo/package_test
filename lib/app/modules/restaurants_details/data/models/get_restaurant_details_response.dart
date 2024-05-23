
class GetRestaurantDetailsResponse {
  int? status;
  String? message;
  Data? data;

  GetRestaurantDetailsResponse({this.status, this.message, this.data});

  GetRestaurantDetailsResponse.fromJson(Map<String, dynamic> json) {
    if(json["status"] is int) {
      status = json["status"];
    }
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  int? totalcount;
  List<Restaurant>? restaurant;

  Data({this.totalcount, this.restaurant});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["totalcount"] is int) {
      totalcount = json["totalcount"];
    }
    if(json["restaurant"] is List) {
      restaurant = json["restaurant"] == null ? null : (json["restaurant"] as List).map((e) => Restaurant.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["totalcount"] = totalcount;
    if(restaurant != null) {
      _data["restaurant"] = restaurant?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Restaurant {
  String? id;
  int? storeId;
  String? branchName;
  String? created;
  Location? location;
  List<MoreBranchDetails>? moreBranchDetails;
  bool? status;
  String? storeAddress;
  String? updated;
  StoreProducts? storeProducts;

  Restaurant({this.id, this.storeId, this.branchName, this.created, this.location, this.moreBranchDetails, this.status, this.storeAddress, this.updated, this.storeProducts});

  Restaurant.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["store_id"] is int) {
      storeId = json["store_id"];
    }
    if(json["branch_name"] is String) {
      branchName = json["branch_name"];
    }
    if(json["created"] is String) {
      created = json["created"];
    }
    if(json["location"] is Map) {
      location = json["location"] == null ? null : Location.fromJson(json["location"]);
    }
    if(json["more_branch_details"] is List) {
      moreBranchDetails = json["more_branch_details"] == null ? null : (json["more_branch_details"] as List).map((e) => MoreBranchDetails.fromJson(e)).toList();
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["store_address"] is String) {
      storeAddress = json["store_address"];
    }
    if(json["updated"] is String) {
      updated = json["updated"];
    }
    if(json["storeProducts"] is Map) {
      storeProducts = json["storeProducts"] == null ? null : StoreProducts.fromJson(json["storeProducts"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["store_id"] = storeId;
    _data["branch_name"] = branchName;
    _data["created"] = created;
    if(location != null) {
      _data["location"] = location?.toJson();
    }
    if(moreBranchDetails != null) {
      _data["more_branch_details"] = moreBranchDetails?.map((e) => e.toJson()).toList();
    }
    _data["status"] = status;
    _data["store_address"] = storeAddress;
    _data["updated"] = updated;
    if(storeProducts != null) {
      _data["storeProducts"] = storeProducts?.toJson();
    }
    return _data;
  }
}

class StoreProducts {
  String? id;
  int? productId;
  String? descriptionBig;
  String? descriptionSmall;
  Images? images;
  int? isActive;
  int? isAvailable;
  String? name;
  String? price;
  String? priceWithoutTax;
  ProductDetails? productDetails;
  double? rating;
  String? serviceProviderId;
  String? serviceProviderLocationId;
  String? productCategoryId;
  ProductCategories? productCategories;

  StoreProducts({this.id, this.productId, this.descriptionBig, this.descriptionSmall, this.images, this.isActive, this.isAvailable, this.name, this.price, this.priceWithoutTax, this.productDetails, this.rating, this.serviceProviderId, this.serviceProviderLocationId, this.productCategoryId, this.productCategories});

  StoreProducts.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["product_id"] is int) {
      productId = json["product_id"];
    }
    if(json["description_big"] is String) {
      descriptionBig = json["description_big"];
    }
    if(json["description_small"] is String) {
      descriptionSmall = json["description_small"];
    }
    if(json["images"] is Map) {
      images = json["images"] == null ? null : Images.fromJson(json["images"]);
    }
    if(json["is_active"] is int) {
      isActive = json["is_active"];
    }
    if(json["is_available"] is int) {
      isAvailable = json["is_available"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["price"] is String) {
      price = json["price"];
    }
    if(json["price_without_tax"] is String) {
      priceWithoutTax = json["price_without_tax"];
    }
    if(json["product_details"] is Map) {
      productDetails = json["product_details"] == null ? null : ProductDetails.fromJson(json["product_details"]);
    }
    if(json["rating"] is double) {
      rating = json["rating"];
    }
    if(json["service_provider_id"] is String) {
      serviceProviderId = json["service_provider_id"];
    }
    if(json["  service_provider_location_id"] is String) {
      serviceProviderLocationId = json["  service_provider_location_id"];
    }
    if(json["product_category_id"] is String) {
      productCategoryId = json["product_category_id"];
    }
    if(json["service_provider_location_id"] is String) {
      serviceProviderLocationId = json["service_provider_location_id"];
    }
    if(json["productCategories"] is Map) {
      productCategories = json["productCategories"] == null ? null : ProductCategories.fromJson(json["productCategories"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["product_id"] = productId;
    _data["description_big"] = descriptionBig;
    _data["description_small"] = descriptionSmall;
    if(images != null) {
      _data["images"] = images?.toJson();
    }
    _data["is_active"] = isActive;
    _data["is_available"] = isAvailable;
    _data["name"] = name;
    _data["price"] = price;
    _data["price_without_tax"] = priceWithoutTax;
    if(productDetails != null) {
      _data["product_details"] = productDetails?.toJson();
    }
    _data["rating"] = rating;
    _data["service_provider_id"] = serviceProviderId;
    _data["  service_provider_location_id"] = serviceProviderLocationId;
    _data["product_category_id"] = productCategoryId;
    _data["service_provider_location_id"] = serviceProviderLocationId;
    if(productCategories != null) {
      _data["productCategories"] = productCategories?.toJson();
    }
    return _data;
  }
}

class ProductCategories {
  String? id;
  String? name;
  dynamic description;
  String? backgroundImage;
  String? heroImage;
  String? icons;
  int? apiCatId;
  String? spLocationId;

  ProductCategories({this.id, this.name, this.description, this.backgroundImage, this.heroImage, this.icons, this.apiCatId, this.spLocationId});

  ProductCategories.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    description = json["description"];
    if(json["background_image"] is String) {
      backgroundImage = json["background_image"];
    }
    if(json["hero_image"] is String) {
      heroImage = json["hero_image"];
    }
    if(json["icons"] is String) {
      icons = json["icons"];
    }
    if(json["api_cat_id"] is int) {
      apiCatId = json["api_cat_id"];
    }
    if(json["sp_location_id"] is String) {
      spLocationId = json["sp_location_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["background_image"] = backgroundImage;
    _data["hero_image"] = heroImage;
    _data["icons"] = icons;
    _data["api_cat_id"] = apiCatId;
    _data["sp_location_id"] = spLocationId;
    return _data;
  }
}

class ProductDetails {
  dynamic productVideoLink;
  int? countOfRating;

  ProductDetails({this.productVideoLink, this.countOfRating});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productVideoLink = json["product_video_link"];
    if(json["count_of_rating"] is int) {
      countOfRating = json["count_of_rating"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["product_video_link"] = productVideoLink;
    _data["count_of_rating"] = countOfRating;
    return _data;
  }
}

class Images {
  String? productImageUrl;
  String? imageSmallSize;
  String? imageMobile;

  Images({this.productImageUrl, this.imageSmallSize, this.imageMobile});

  Images.fromJson(Map<String, dynamic> json) {
    if(json["product_imageUrl"] is String) {
      productImageUrl = json["product_imageUrl"];
    }
    if(json["image_small_size"] is String) {
      imageSmallSize = json["image_small_size"];
    }
    if(json["image_mobile"] is String) {
      imageMobile = json["image_mobile"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["product_imageUrl"] = productImageUrl;
    _data["image_small_size"] = imageSmallSize;
    _data["image_mobile"] = imageMobile;
    return _data;
  }
}

class MoreBranchDetails {
  String? cityName;
  String? landmark;
  String? localityName;
  String? societyName;
  int? parentStoreId;
  String? onTime;
  String? offTime;
  String? storeCode;

  MoreBranchDetails({this.cityName, this.landmark, this.localityName, this.societyName, this.parentStoreId, this.onTime, this.offTime, this.storeCode});

  MoreBranchDetails.fromJson(Map<String, dynamic> json) {
    if(json["city_name"] is String) {
      cityName = json["city_name"];
    }
    if(json["landmark"] is String) {
      landmark = json["landmark"];
    }
    if(json["locality_name"] is String) {
      localityName = json["locality_name"];
    }
    if(json["society_name"] is String) {
      societyName = json["society_name"];
    }
    if(json["parent_store_id"] is int) {
      parentStoreId = json["parent_store_id"];
    }
    if(json["onTime"] is String) {
      onTime = json["onTime"];
    }
    if(json["offTime"] is String) {
      offTime = json["offTime"];
    }
    if(json["store_code"] is String) {
      storeCode = json["store_code"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["city_name"] = cityName;
    _data["landmark"] = landmark;
    _data["locality_name"] = localityName;
    _data["society_name"] = societyName;
    _data["parent_store_id"] = parentStoreId;
    _data["onTime"] = onTime;
    _data["offTime"] = offTime;
    _data["store_code"] = storeCode;
    return _data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["coordinates"] is List) {
      coordinates = json["coordinates"] == null ? null : List<double>.from(json["coordinates"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if(coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }
}