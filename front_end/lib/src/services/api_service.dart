import 'dart:convert';
import 'dart:developer';

import 'package:getgoods/src/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiService {
  Future<List<ProductModel>?> getProducts() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.productsEndpoint);
      var response = await http.get(url);
      log(response.body);

      if (response.statusCode == 200) {
        List<ProductModel> model = productModelFromJson(response.body);
        for (var item in model) {
          log(item.image);
        }
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  List<ProductModel> productModelFromJson(String body) {
    final jsonData = json.decode(body);
    final dataList = jsonData['data']['products'];

    return List<ProductModel>.from(dataList.map((json) {
      return ProductModel(
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        images: List<String>.from(json['images'] ?? []),
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        quantity: json['quantity'] ?? 0,
        price: (json['price'] ?? 0).toDouble(),
        discountPercentage: json['discount'] ?? 0,
        sold: json['sold'] ?? 0,
        ratingsAverage: (json['ratingsAverage'] ?? 0).toDouble(),
        ratingsQuantity: (json['ratingsQuantity'] ?? 0).toDouble(),
        image: json['imageCover'] ?? '',
        shop: json['shop'] ?? '',
        createdAt: json['createdAt'] ?? '',
        updatedAt: json['updatedAt'] ?? '',
        slug: json['slug'] ?? '',
      );
    }));
  }
}
