import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier{
  // list of items
  final List _foodItems = [
    // [productName vendorsName imageUrl color]
    ["Cayenne Pepper", "Dami's Shop", "lib/images/chilli_pepper.jpg", "Colors.yellow"],
    ["Bananas", "Francesca's Shop", "lib/images/banana.jpg", "Colors.yellow"],
    ["Eggs", "Kaouter's Shop", "lib/images/eggs.jpg", "Colors.yellow"],
    ["Mackerel", "Faizah's Shop", "lib/images/titus.jpg", "Colors.yellow"],
  ];
  get foodItems => _foodItems;
}