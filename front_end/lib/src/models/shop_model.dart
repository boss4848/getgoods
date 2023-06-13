class Shop {
  final String id;
  final String name;
  final Location location;

  Shop({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
    );
  }

  factory Shop.empty() {
    return Shop(
      id: '',
      name: '',
      location: Location.empty(),
    );
  }
}

class ShopDetail {
  final String id;
  final String name;
  final Location location;
  final String description;

  ShopDetail({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
  });

  factory ShopDetail.fromJson(Map<String, dynamic> json) {
    return ShopDetail(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      description: json['description'] ?? '',
    );
  }

  factory ShopDetail.empty() {
    return ShopDetail(
      id: '',
      name: '',
      location: Location.empty(),
      description: '',
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

  Location({
    required this.provinceTh,
    required this.provinceEn,
    required this.districtTh,
    required this.districtEn,
    required this.subDistrictTh,
    required this.subDistrictEn,
    required this.postCode,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      provinceTh: json['province_th'] ?? '',
      provinceEn: json['province_en'] ?? '',
      districtTh: json['district_th'] ?? '',
      districtEn: json['district_en'] ?? '',
      subDistrictTh: json['subDistrict_th'] ?? '',
      subDistrictEn: json['subDistrict_en'] ?? '',
      postCode: json['postCode'] ?? '',
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
    );
  }
}
