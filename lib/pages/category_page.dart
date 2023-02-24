import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../items/product_item_tile.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //search feature
          searchBox(),
          //items + grid
          Expanded(child: GridView.builder
            (gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
            (crossAxisCount: 2),
              itemBuilder: (context, index){
                return ProductItemTile(productName: '', productPrice: '', vendorsName: '', imageUrl: '', color: '',);
              }
          ),
          )
        ],
      ),
    );
  }
}
Widget searchBox(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20)
        ),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
                size: 20,
              ),
              prefixIconConstraints: BoxConstraints(
                  maxHeight: 20,
                  minWidth: 25),
              border: InputBorder.none,
              hintText: "Search products, stores, categories",
              hintStyle: TextStyle(color: Colors.grey)
          ),
        )

    ),
  );
}
