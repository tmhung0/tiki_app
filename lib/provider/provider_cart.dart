import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final String image;
  final int price;
  late int quantity;
  late bool ischecked;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.ischecked,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "quantity": quantity,
    };
  }
}

class CartProvider extends ChangeNotifier {
  //list
  final List<CartItem> _cartList = [];
  //check
  late bool _allischecked = true;
  //get list
  List<CartItem> get cartList => _cartList;
  //get check
  bool get allischecked => _allischecked;

  checkitem(CartItem item, value) {
    item.ischecked = value;
    notifyListeners();
  }

  set allischecked(bool value) {
    _allischecked = value;
    notifyListeners();
  }

  myCartCount() {
    int count = 0;
    for (var item in _cartList.where((p) => p.ischecked == true).toList()) {
      count += item.quantity;
    }
    return count;
  }

  clearCart() {
    _cartList.clear();
    notifyListeners();
  }

  removeItem(
    String id,
  ) {
    _cartList.remove(_cartList.firstWhere((p) => p.id == id));
    notifyListeners();
  }

  addItemToCart(
    String id,
    String name,
    String image,
    int price,
  ) {
    if (_cartList.where((p) => p.id == id).isNotEmpty) {
      _cartList.firstWhere((p) => p.id == id).quantity += 1;
    } else {
      _cartList.add(CartItem(
          id: id,
          name: name,
          image: image,
          price: price.toInt(),
          quantity: 1,
          ischecked: true));
    }
    notifyListeners();
  }

  getCartTotal() {
    double price = 0;
    for (var item in _cartList.where((p) => p.ischecked == true).toList()) {
      price += item.quantity * item.price;
    }
    return price;
  }

  void sub(CartItem item) {
    item.quantity--;
    if (item.quantity < 1) {
      item.quantity = 1;
    }
    notifyListeners();
  }

  void add(CartItem item) {
    item.quantity++;
    notifyListeners();
  }
}
