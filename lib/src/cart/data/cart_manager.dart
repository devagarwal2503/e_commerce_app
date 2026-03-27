import 'dart:convert';

import 'package:e_commerce_app/core/services/injection_container.dart';
import 'package:e_commerce_app/src/cart/data/model/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartManager {
  static const String _key = 'user_cart';

  // Get all items
  static Future<List<CartItem>> getCart() async {
    final prefs = await sl<SharedPreferences>();
    final List<String>? data = prefs.getStringList(_key);
    if (data == null) return [];
    return data.map((item) => CartItem.fromJson(jsonDecode(item))).toList();
  }

  // The logic you were worried about: Adding without overwriting
  static Future<void> addItem(CartItem item) async {
    final cart = await getCart();
    final index = cart.indexWhere((element) => element.id == item.id);

    if (index >= 0) {
      cart[index].quantity += 1;
    } else {
      cart.add(item);
    }

    await _save(cart);
  }

  // Private helper to save the list
  static Future<void> _save(List<CartItem> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> data = cart
        .map((item) => jsonEncode(item.toJson()))
        .toList();
    await prefs.setStringList(_key, data);
  }

  static Future<void> removeItem(String productId) async {
    final cart = await getCart();
    // Remove the item where the ID matches
    cart.removeWhere((item) => item.id == productId);
    await _save(cart);
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static Future<void> decrementItem(String productId) async {
    final cart = await getCart();
    final index = cart.indexWhere((item) => item.id == productId);

    if (index != -1) {
      if (cart[index].quantity > 1) {
        // If more than 1, just reduce the count
        cart[index].quantity -= 1;
      } else {
        // If it's the last one, remove it entirely
        cart.removeAt(index);
      }
      await _save(cart);
    }
  }
}
