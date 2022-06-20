import 'package:flutter/material.dart';

class InventoryMember {
  late final String _name;
  late final int _quantity;

  int get quantity => _quantity;
  String get name => _name;

  InventoryMember(String s, int i){
    _name = s;
    _quantity = i;
  }
  InventoryMember add() {
    return InventoryMember(name, quantity + 1);
  }
  InventoryMember remove() {
    return InventoryMember(name, quantity - 1);
  }
  InventoryMember rename(String newName) {
    return InventoryMember(newName, quantity);
  }
}