import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItemTile extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String vendorsName;
  final String imageUrl;
  final String color;


  const ProductItemTile({super.key,
    required this.productName,
    required this.productPrice,
    required this.vendorsName,
    required this.imageUrl,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
