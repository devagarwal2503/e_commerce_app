part of 'product_details_bloc.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

class GettingProductDetailsState extends ProductDetailsState {
  const GettingProductDetailsState();
}

class FetchedProductDetailsState extends ProductDetailsState {
  const FetchedProductDetailsState(this.productDetails);
  final List<ProductDetailsModel> productDetails;
}

class ProductDetailsFailedState extends ProductDetailsState {
  const ProductDetailsFailedState(this.errorMessage);

  final String errorMessage;
}

class ProductInCartSuccessState extends ProductDetailsState {
  const ProductInCartSuccessState(this.isInCart);
  final bool isInCart;

  @override
  List<Object> get props => [isInCart];
}

class AddingProductToCartState extends ProductDetailsState {
  const AddingProductToCartState(this.isInCart);
  final bool isInCart;
}
