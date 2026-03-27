import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/src/cart/data/cart_manager.dart';
import 'package:e_commerce_app/src/cart/data/model/cart_item_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {});

    on<LoadCart>((event, emit) async {
      emit(CartLoadingState());
      final items = await CartManager.getCart();
      if (items == [] || items.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(
          CartLoadedState(items: items, totalAmount: _calculateTotal(items)),
        );
      }
    });

    // 2. Add Item
    on<AddItemEvent>((event, emit) async {
      await CartManager.addItem(event.item);
      // add(LoadCart()); // Refresh the list after adding
    });

    // 3. Remove Entire Item
    on<RemoveItemEvent>((event, emit) async {
      await CartManager.removeItem(event.productId);
      add(LoadCart()); // Refresh the list after removing
    });

    // 4. Decrement (Minus Button)
    on<DecrementItemEvent>((event, emit) async {
      await CartManager.decrementItem(event.productId);
      add(LoadCart()); // Refresh the list after decrementing
    });

    on<ClearCart>((event, emit) async {
      await CartManager.clearCart();
      add(LoadCart()); // Refresh the list after decrementing
    });
  }

  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}
