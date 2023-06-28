class CartItem {
  final String shopName;
  final List<ProductCart> products;

  CartItem({
    required this.shopName,
    required this.products,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      shopName: json['shop']['name'] ?? '',
      products: List<Map<String, dynamic>>.from(json['shop']['products'] ?? [])
          .map((productJson) => ProductCart.fromJson(productJson))
          .toList(),
    );
  }

  factory CartItem.empty() {
    return CartItem(
      shopName: '',
      products: [],
    );
  }
}

class ProductCart {
  final String cartItemId;
  final String productId;
  final String name;
  final String description;
  final double price;
  final double discount;
  final int quantity;
  final String imageCover;
  final int stock;

  ProductCart({
    required this.cartItemId,
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.imageCover,
    required this.stock,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
      cartItemId: json['cartItemId'] ?? '',
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      imageCover: json['imageCover'] ?? '',
      stock: json['stock'] ?? 0,
    );
  }
}
