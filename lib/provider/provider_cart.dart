import 'package:flutter/material.dart';
import 'package:tiki_app/item.dart';

class Cart extends ChangeNotifier {
  List<Item> _items = [];
  int _price = 0;

  void add(Item item) {
    _items.add(item);

    _price += item.price;
    notifyListeners();
  }

  void remote(Item item) {
    _items.remove(item);
    _price -= item.price;
    notifyListeners();
  }

  void remoteAll() {
    _items.clear();
    _price = 0;
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  int get totalPrice {
    return _price;
  }

  List<Item> get basketitem {
    return _items;
  }
}
