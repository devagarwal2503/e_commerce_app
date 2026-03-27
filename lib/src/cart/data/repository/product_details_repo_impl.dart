import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exception.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/cart/data/datasources/product_details_datasource.dart';
import 'package:e_commerce_app/src/cart/data/model/product_details_model.dart';
import 'package:e_commerce_app/src/cart/domain/repository/product_details_repo.dart';

class ProductDetailsRepoImpl implements ProductDetailsRepo {
  const ProductDetailsRepoImpl(this._productDetailsDatasource);

  final ProductDetailsDatasource _productDetailsDatasource;

  @override
  ResultFuture<List<ProductDetailsModel>> getProductDetails() async {
    try {
      final result = await _productDetailsDatasource.getProductDetails();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
