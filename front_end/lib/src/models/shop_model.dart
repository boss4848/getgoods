import 'product_model.dart';

class Shop {
  final String ownerId;
  final String id;
  final String name;
  final Location location;
  final String ownerId;

  Shop({
    required this.ownerId,
    required this.id,
    required this.name,
    required this.location,
    required this.ownerId,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      ownerId: json['owner']['_id'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      ownerId: json['owner']['_id'] ?? '',
    );
  }

  factory Shop.empty() {
    return Shop(
      ownerId: '',
      id: '',
      name: '',
      location: Location.empty(),
      ownerId: '',
    );
  }
}

class ShopDetail {
  final String id;
  final String name;
  final Location location;
  final String description;
  final Owner owner;
  final List<Product> products;

  ShopDetail({
    required this.owner,
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.products,
  });

  factory ShopDetail.fromJson(Map<String, dynamic> json) {
    return ShopDetail(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      description: json['description'] ?? '',
      owner: Owner.fromJson(json['owner'] ?? {}),
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      // products: (json['products'] as List<dynamic>?)
      //         ?.map((e) => ProductDetail.fromJson(e as Map<String, dynamic>))
      //         .toList() ??
      //     [],
    );
  }

  factory ShopDetail.empty() {
    return ShopDetail(
      id: '',
      name: '',
      location: Location.empty(),
      description: '',
      owner: Owner.empty(),
      products: [],
    );
  }
}

class Location {
  final String provinceTh;
  final String provinceEn;
  final String districtTh;
  final String districtEn;
  final String subDistrictTh;
  final String subDistrictEn;
  final String postCode;
  final String detail;

  Location({
    required this.provinceTh,
    required this.provinceEn,
    required this.districtTh,
    required this.districtEn,
    required this.subDistrictTh,
    required this.subDistrictEn,
    required this.postCode,
    required this.detail,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      provinceTh: json['province_th'] ?? '',
      provinceEn: json['province_en'] ?? '',
      districtTh: json['district_th'] ?? '',
      districtEn: json['district_en'] ?? '',
      subDistrictTh: json['sub_district_th'] ?? '',
      subDistrictEn: json['sub_district_en'] ?? '',
      postCode: json['post_code'] ?? '',
      detail: json['detail'] ?? '',
    );
  }

  factory Location.empty() {
    return Location(
      provinceTh: '',
      provinceEn: '',
      districtTh: '',
      districtEn: '',
      subDistrictTh: '',
      subDistrictEn: '',
      postCode: '',
      detail: '',
    );
  }
}

class Owner {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String photo;
  final Location address;

  Owner({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photo,
    required this.address,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      photo: json['photo'] ?? '',
      address: Location.fromJson(json['address'] ?? {}),
    );
  }

  factory Owner.empty() {
    return Owner(
      id: '',
      name: '',
      email: '',
      phoneNumber: '',
      photo: '',
      address: Location.empty(),
    );
  }
}
