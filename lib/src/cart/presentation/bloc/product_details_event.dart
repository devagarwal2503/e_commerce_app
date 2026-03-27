part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetails extends ProductDetailsEvent {
  const GetProductDetails();
}

class IsProductInCart extends ProductDetailsEvent {
  const IsProductInCart({required this.productId});

  final String productId;
}
