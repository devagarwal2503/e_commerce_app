part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoadedState extends CartState {
  const CartLoadedState({required this.items, required this.totalAmount});

  final List<CartItem> items;
  final double totalAmount;
}

class CartLoadingState extends CartState {
  const CartLoadingState();
}

class CartEmptyState extends CartState {
  const CartEmptyState();
}
