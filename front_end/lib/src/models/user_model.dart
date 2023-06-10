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
  final String photo;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String shop;

  UserDetail({
    required this.photo,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.shop,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      photo: json['photo'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      shop: json['shop'] ?? '',
    );
  }

  factory UserDetail.empty() {
    return UserDetail(
      photo: '',
      name: '',
      email: '',
      phone: '',
      address: '',
      shop: '',
    );
  }
}
