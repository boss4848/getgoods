import 'shop_model.dart';

class ProductDetail {
  final String id;
  final String name;
  final List<String> images;
  final String description;
  final String category;
  final int quantity;
  final double price;
  final double discount;
  final int sold;
  final double ratingsAverage;
  final int ratingsQuantity;
  final Shop shop;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String slug;
  final String imageCover;

  ProductDetail({
    required this.id,
    required this.name,
    required this.images,
    required this.description,
    required this.category,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.sold,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.shop,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.imageCover,
  });

  factory ProductDetail.empty() {
    return ProductDetail(
      id: '',
      name: '',
      images: [],
      description: '',
      category: '',
      quantity: 0,
      price: 0.0,
      discount: 0.0,
      sold: 0,
      ratingsAverage: 0.0,
      ratingsQuantity: 0,
      shop: Shop.empty(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      slug: '',
      imageCover: '',
    );
  }

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['_id'],
      name: json['name'],
      images: List<String>.from(json['images']),
      description: json['description'],
      category: json['category'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      discount: json['discount'].toDouble(),
      sold: json['sold'],
      ratingsAverage: json['ratingsAverage'].toDouble(),
      ratingsQuantity: json['ratingsQuantity'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      slug: json['slug'],
      imageCover: json['imageCover'],
      shop: Shop.fromJson(
        json['shop'] ??
            {
              // 'name': '',
              // 'location': '',
            },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final int discount;
  final int sold;
  final String imageCover;
  final String id;
  final int quantity;

  Product({
    required this.name,
    required this.price,
    required this.discount,
    required this.sold,
    this.imageCover = '',
    required this.id,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      price: json['price'].toDouble() ?? 0.0,
      discount: json['discount'].toInt() ?? 0,
      sold: json['sold'] ?? 0,
      imageCover: json['imageCover'] ?? '',
      id: json['_id'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }
}

class CheckoutProduct {
  final String shopId;
  final String shopName;
  final String id;
  final String name;
  final double price;
  final double discount;
  final int quantity;
  final String imageCover;

  CheckoutProduct({
    required this.shopId,
    required this.shopName,
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.imageCover,
  });

  factory CheckoutProduct.fromJson(Map<String, dynamic> json) {
    return CheckoutProduct(
      shopId: json['shopId'],
      shopName: json['shopName'],
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      discount: json['discount'].toDouble(),
      quantity: json['quantity'],
      imageCover: json['imageCover'],
    );
  }

  factory CheckoutProduct.empty() {
    return CheckoutProduct(
      shopId: '',
      shopName: '',
      id: '',
      name: '',
      price: 0.0,
      discount: 0.0,
      quantity: 0,
      imageCover: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shopId': shopId,
      'shopName': shopName,
      '_id': id,
      'name': name,
      'price': price,
      'discount': discount,
      'quantity': quantity,
      'imageCover': imageCover,
    };
  }
}
