class Shop {
  final String id;
  final String name;
  final String location;

  Shop({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
    );
  }

  factory Shop.empty() {
    return Shop(
      id: '',
      name: '',
      location: '',
    );
  }
}

class ShopDetail {
  final String id;
  final String name;
  final String location;
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
      location: json['location'] ?? '',
      description: json['description'] ?? '',
    );
  }

  factory ShopDetail.empty() {
    return ShopDetail(
      id: '',
      name: '',
      location: '',
      description: '',
    );
  }
}
