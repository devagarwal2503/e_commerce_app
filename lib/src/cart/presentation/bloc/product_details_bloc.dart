import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/src/cart/data/cart_manager.dart';
import 'package:e_commerce_app/src/cart/data/model/product_details_model.dart';
import 'package:e_commerce_app/src/cart/domain/usecases/get_product_details_usecase.dart';
import 'package:equatable/equatable.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc({
    required GetProductDetailsUsecase getProductDetailsUsecase,
  }) : _getProductDetailsUsecase = getProductDetailsUsecase,
       super(ProductDetailsInitial()) {
    on<ProductDetailsEvent>((event, emit) {});
    on<GetProductDetails>(_getProductDetails);
    on<IsProductInCart>(_isProductInCart);
  }

  final GetProductDetailsUsecase _getProductDetailsUsecase;

  Future<void> _getProductDetails(
    ProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    final result = await _getProductDetailsUsecase();

    result.fold(
      (failure) {
        return emit(ProductDetailsFailedState(failure.errorMessage));
      },
      (productDetails) {
        return emit(FetchedProductDetailsState(productDetails));
      },
    );
  }

  Future<bool> _isProductInCart(
    IsProductInCart event,
    Emitter<ProductDetailsState> emit,
  ) async {
    final cartItems = await CartManager.getCart();
    final exists = cartItems.any((item) => item.id == event.productId);
    emit(ProductInCartSuccessState(exists));
    return exists;
  }
}
