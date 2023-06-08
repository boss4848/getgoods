class ProductModel {
  final int discountPercentage;
  final String slug;
  final String description;
  final String category;
  final int quantity;
  final double ratingsAverage;
  final double ratingsQuantity;
  final String image;
  final String name;
  final double price;
  final int sold;
  final List<String> images;
  final String shop;
  final String createdAt;
  final String updatedAt;
  final String id;

  ProductModel({
    this.discountPercentage = 0,
    required this.slug,
    required this.description,
    required this.category,
    required this.quantity,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.price,
    this.name =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    required this.image,
    this.sold = 0,
    required this.images,
    required this.shop,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });
// type '(dynamic) => ProductModel' is not a subtype of type '(String, dynamic) => MapEntry<dynamic, dynamic>' of 'transform'
  // factory ProductModel.fromJson(Map<String, dynamic> json) {
  //   return ProductModel(
  //     image: json['imageCover'] ?? "",
  //     images: json['images'] ?? [""],
  //     slug: json['slug'] ?? "",
  //     description: json['description'] ?? "",
  //     category: json['category'] ?? "",
  //     quantity: json['quantity'] ?? 0,
  //     price: json['price'] ?? 0.0,
  //     discountPercentage: json['discount'] ?? 0,
  //     name: json['name'] ?? "",
  //     sold: json['sold'] ?? 0,
  //     ratingsAverage: json['ratingsAverage'] ?? 0.0,
  //     shop: json['shop'] ?? "",
  //     createdAt: json['createdAt'] ?? "",
  //     updatedAt: json['updatedAt'] ?? "",
  //     id: json['_id'] ?? "",
  //     ratingsQuantity: json['ratingsQuantity'] ?? 0,
  //   );
  // }
}

class ReviewModel {}
