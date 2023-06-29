import 'package:getgoods/src/models/product_model.dart';
import 'package:getgoods/src/models/shop_model.dart';

import 'user_model.dart';

class Transaction {
  final String id;
  final double amount;
  // final Product product;
  final double shippingFree;
  final String status;
  final String paymentIntentId;
  final String sessionId;
  final String receiptUrl;
  final String checkoutUrl;
  final String chargeId;
  final UserTransaction user;
  // final ShopTransaction shop;
  // final String shopId;
  final Shop shop;
  final List<ProductTransaction> products;
  final DateTime createdAt;
  final List<int> quantity;
  final double shippingFee;

  Transaction({
    required this.id,
    required this.amount,
    required this.quantity,
    // required this.product,
    required this.shippingFree,
    required this.status,
    required this.paymentIntentId,
    required this.sessionId,
    required this.receiptUrl,
    required this.checkoutUrl,
    required this.chargeId,
    required this.user,
    // required this.shopId,
    required this.shop,
    required this.products,
    required this.createdAt,
    required this.shippingFee,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      shippingFree: (json['shippingFee'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      paymentIntentId: json['paymentIntentId'] ?? '',
      sessionId: json['sessionId'] ?? '',
      receiptUrl: json['receiptUrl'] ?? '',
      checkoutUrl: json['checkoutUrl'] ?? '',
      chargeId: json['chargeId'] ?? '',
      user: UserTransaction.fromJson(json['user'] ?? {}),
      // shop: ShopTransaction.fromJson(json['shop'] ?? {}),
      // shopId: json['shop'] ?? '',
      shop: Shop.fromJson(json['shop'] ?? {}),
      products: List<ProductTransaction>.from(
        json['products'].map(
          (product) => ProductTransaction.fromJson(product),
        ),
      ),
      createdAt: DateTime.parse(json['createdAt']),
      quantity: List<int>.from(json['quantity'].map((e) => e)),
      shippingFee: (json['shippingFee'] ?? 0).toDouble(),
    );
  }
}

class UserTransaction {
  final String id;
  final String name;
  final String email;
  final Location location;

  UserTransaction({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
  });

  factory UserTransaction.fromJson(Map<String, dynamic> json) {
    return UserTransaction(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
    );
  }
}

class ShopTransaction {
  final String id;
  final String name;
  final UserDetail owner;

  ShopTransaction({
    required this.id,
    required this.name,
    required this.owner,
  });

  factory ShopTransaction.fromJson(Map<String, dynamic> json) {
    return ShopTransaction(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      owner: UserDetail.fromJson(json['owner'] ?? {}),
    );
  }
}

class ProductTransaction {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageCover;

  ProductTransaction({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageCover,
  });

  factory ProductTransaction.fromJson(Map<String, dynamic> json) {
    return ProductTransaction(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      imageCover: json['imageCover'] ?? '',
    );
  }
}

// class Transaction {
//   final String id;
//   final double amount;
//   final User user;
//   final Shop shop;
//   final List<Product> products;
//   final String stripeId;
//   final String status;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Transaction({
//     required this.id,
//     required this.amount,
//     required this.user,
//     required this.shop,
//     required this.products,
//     required this.stripeId,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Transaction.fromJson(Map<String, dynamic> json) {
//     return Transaction(
//       id: json['_id'] ?? '',
//       amount: json['amount'].toDouble() ?? 0.0,
//       user: User.fromJson(json['user'] ?? {}) ?? User.empty(),
//       shop: Shop.fromJson(json['shop'] ?? {}) ?? Shop.empty(),
//       products: List<Product>.from(
//           json['products']?.map((product) => Product.fromJson(product)) ?? []),
//       stripeId: json['stripeId'] ?? '',
//       status: json['status'] ?? '',
//       createdAt: DateTime.parse(json['createdAt'] ?? ''),
//       updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
//     );
//   }
// }

// class User {
//   final String id;
//   final String name;
//   final String email;
//   final Address address;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.address,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       address: Address.fromJson(json['address']) ?? Address.empty(),
//     );
//   }

//   factory User.empty() {
//     return User(
//       id: '',
//       name: '',
//       email: '',
//       address: Address.empty(),
//     );
//   }
// }

// class Shop {
//   final String id;
//   final String name;
//   final Owner owner;

//   Shop({
//     required this.id,
//     required this.name,
//     required this.owner,
//   });

//   factory Shop.fromJson(Map<String, dynamic>? json) {
//     if (json == null) {
//       return Shop.empty();
//     }

//     return Shop(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       owner: Owner.fromJson(json['owner']) ?? Owner.empty(),
//     );
//   }
// }

// class Owner {
//   final String id;
//   final String name;
//   final String email;
//   final String photo;
//   final String phone;
//   final String address;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Owner({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.photo,
//     required this.phone,
//     required this.address,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Owner.fromJson(Map<String, dynamic> json) {
//     return Owner(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       photo: json['photo'] ?? '',
//       phone: json['phone'] ?? '',
//       address: json['address'] ?? '',
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }

//   factory Owner.empty() {
//     return Owner(
//       id: '',
//       name: '',
//       email: '',
//       photo: '',
//       phone: '',
//       address: '',
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//     );
//   }
// }

// class Address {
//   final String detail;
//   final String provinceEn;
//   final String provinceTh;
//   final String districtEn;
//   final String districtTh;
//   final String subDistrictEn;
//   final String subDistrictTh;
//   final String postCode;

//   Address({
//     required this.detail,
//     required this.provinceEn,
//     required this.provinceTh,
//     required this.districtEn,
//     required this.districtTh,
//     required this.subDistrictEn,
//     required this.subDistrictTh,
//     required this.postCode,
//   });

//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       detail: json['detail'],
//       provinceEn: json['province_en'] ?? '',
//       provinceTh: json['province_th'] ?? '',
//       districtEn: json['district_en'] ?? '',
//       districtTh: json['district_th'] ?? '',
//       subDistrictEn: json['sub_district_en'] ?? '',
//       subDistrictTh: json['sub_district_th'] ?? '',
//       postCode: json['post_code'] ?? '',
//     );
//   }

//   factory Address.empty() {
//     return Address(
//       detail: '',
//       provinceEn: '',
//       provinceTh: '',
//       districtEn: '',
//       districtTh: '',
//       subDistrictEn: '',
//       subDistrictTh: '',
//       postCode: '',
//     );
//   }
// }

// class Product {
//   final String id;
//   final String name;
//   final String imageCover;
//   final int quantity;
//   final double price;

//   Product({
//     required this.id,
//     required this.name,
//     required this.imageCover,
//     required this.quantity,
//     required this.price,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       imageCover: json['imageCover'] ?? '',
//       quantity: json['quantity'] ?? 0,
//       price: json['price'].toDouble() ?? 0.0,
//     );
//   }

//   factory Product.empty() {
//     return Product(
//       id: '',
//       name: '',
//       imageCover: '',
//       quantity: 0,
//       price: 0.0,
//     );
//   }
// }
