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
