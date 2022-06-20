import 'package:flutter/material.dart';

class Product {
  late final String _name;
  late final int _quantity;

  int get quantity => _quantity;
  String get name => _name;

  Product(String s, int i){
    _name = s;
    _quantity = i;
  }
  Product add() {
    return Product(name, quantity + 1);
  }
  Product remove() {
    return Product(name, quantity - 1);
  }
  Product rename(String newName) {
    return Product(newName, quantity);
  }
}