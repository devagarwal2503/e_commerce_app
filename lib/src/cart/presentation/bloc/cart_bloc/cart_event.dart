part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddItemEvent extends CartEvent {
  final CartItem item;
  AddItemEvent(this.item);
}

class RemoveItemEvent extends CartEvent {
  final String productId;
  RemoveItemEvent(this.productId);
}

class DecrementItemEvent extends CartEvent {
  final String productId;
  DecrementItemEvent(this.productId);
}

class ClearCart extends CartEvent {
  const ClearCart();
}
