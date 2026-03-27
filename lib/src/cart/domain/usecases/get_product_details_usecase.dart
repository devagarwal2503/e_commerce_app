import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/cart/data/model/product_details_model.dart';
import 'package:e_commerce_app/src/cart/domain/repository/product_details_repo.dart';

class GetProductDetailsUsecase extends UsecaseWithoutParameters {
  const GetProductDetailsUsecase(this._productDetailsRepo);
  final ProductDetailsRepo _productDetailsRepo;

  @override
  ResultFuture<List<ProductDetailsModel>> call() async {
    return _productDetailsRepo.getProductDetails();
  }
}
