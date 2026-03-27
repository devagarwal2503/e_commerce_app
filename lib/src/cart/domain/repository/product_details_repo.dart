import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/cart/data/model/product_details_model.dart';

abstract class ProductDetailsRepo {
  const ProductDetailsRepo();

  ResultFuture<List<ProductDetailsModel>> getProductDetails();
}
