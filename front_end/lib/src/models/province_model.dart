class Province {
  final String id;
  final String code;
  final String nameTh;
  final String nameEn;
  final String geographyId;

  Province({
    required this.id,
    required this.code,
    required this.nameTh,
    required this.nameEn,
    required this.geographyId,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      code: json['code'],
      nameTh: json['name_th'],
      nameEn: json['name_en'],
      geographyId: json['geography_id'],
    );
  }

  factory Province.empty() {
    return Province(
      id: '',
      code: '',
      nameTh: '',
      nameEn: '',
      geographyId: '',
    );
  }
}
