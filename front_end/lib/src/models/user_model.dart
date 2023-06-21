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
  final String address;
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
      address: json['address'] ?? '',
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
      address: '',
      shop: ShopDetail.empty(),
    );
  }
}
