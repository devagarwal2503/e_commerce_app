import 'dart:convert';

import 'package:e_commerce_app/core/errors/exception.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/src/cart/data/model/product_details_model.dart';
import 'package:flutter/services.dart';

abstract class ProductDetailsDatasource {
  const ProductDetailsDatasource();

  Future<List<ProductDetailsModel>> getProductDetails();
}

class ProductDetailsDatasourceImpl extends ProductDetailsDatasource {
  const ProductDetailsDatasourceImpl();

  @override
  Future<List<ProductDetailsModel>> getProductDetails() async {
    try {
      final String response = await rootBundle.loadString(
        MediaResources.productDetails,
      );

      final dynamic jsonData = jsonDecode(response);

      if (jsonData is List) {
        return jsonData.map((e) => ProductDetailsModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data, JSON structure is not a list.');
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
