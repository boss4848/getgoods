import 'shop_model.dart';

class User {
  final String photo;
  final String name;

  User({
    required this.photo,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      photo: json['photo'] ??
          'https://getgoods.blob.core.windows.net/user-photos/default.png',
      name: json['name'] ?? '',
    );
  }

  factory User.empty() {
    return User(
      photo: 'https://getgoods.blob.core.windows.net/user-photos/default.png',
      name: '',
    );
  }
}

class UserDetail {
  final String id;
  final String photo;
  final String name;
  final String email;
  final String phone;
  //final String address;
  final Address address;
  final ShopDetail shop;

  UserDetail({
    required this.id,
    required this.photo,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.shop,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    var shopJson = json['shop'];
    ShopDetail shop;
    if (shopJson == null || shopJson.isEmpty) {
      shop = ShopDetail.empty();
    } else if (shopJson is List) {
      shop = ShopDetail.fromJson(shopJson.first as Map<String, dynamic>);
    } else {
      shop = ShopDetail.fromJson(shopJson as Map<String, dynamic>);
    }
    return UserDetail(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photo: json['photo'] ?? '',
      phone: json['phone'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
      shop: shop,
    );
  }

  factory UserDetail.empty() {
    return UserDetail(
      id: '',
      photo: '',
      name: '',
      email: '',
      phone: '',
      address: Address.empty(),
      shop: ShopDetail.empty(),
    );
  }
}

class Address {
  final String provinceTh;
  final String provinceEn;
  final String districtTh;
  final String districtEn;
  final String subDistrictTh;
  final String subDistrictEn;
  final String postCode;
  final String detail;

  Address({
    required this.provinceTh,
    required this.provinceEn,
    required this.districtTh,
    required this.districtEn,
    required this.subDistrictTh,
    required this.subDistrictEn,
    required this.postCode,
    required this.detail,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
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

  factory Address.empty() {
    return Address(
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
