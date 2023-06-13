class SubDistrict {
  final String id;
  final String zipCode;
  final String nameTh;
  final String nameEn;
  final String districtId;

  SubDistrict({
    required this.id,
    required this.zipCode,
    required this.nameTh,
    required this.nameEn,
    required this.districtId,
  });

  factory SubDistrict.fromJson(Map<String, dynamic> json) {
    return SubDistrict(
      id: json['id'] ?? '',
      zipCode: json['zip_code'] ?? '',
      nameTh: json['name_th'] ?? '',
      nameEn: json['name_en'] ?? '',
      districtId: json['district_id'] ?? '',
    );
  }

  factory SubDistrict.empty() {
    return SubDistrict(
      id: '',
      zipCode: '',
      nameTh: '',
      nameEn: '',
      districtId: '',
    );
  }
}
