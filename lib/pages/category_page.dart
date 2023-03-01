import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_solve/pages/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../items/product_item.dart';
import '../items/product_item_tile.dart';

class CategoryPage extends StatefulWidget {
   CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List _products = [];

  var _firestoreInstance = FirebaseFirestore.instance;

  fetchProducts() async {

    QuerySnapshot qn =
    await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add(
            {
              "product-name": qn.docs[i]["product-name"],
              "product-description": qn.docs[i]["product-description"],
              "price": qn.docs[i]["price"],
              "product-img": qn.docs[i]["product-img"],
              "quantity": qn.docs [i]["quantity"],
            }
        );

      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            //search feature
            searchBox(),
            //items + grid
            GridView.builder(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductItem(_products[index]))),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                          aspectRatio: 2,
                          child: Image.network(_products[index]["product-img"]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _products[index]["product-name"],
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "₦ ${_products[index]["price"].toStringAsFixed(2)}",
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.lime.shade700
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
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
            onTap: ()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>SearchPage())),
          )

      ),
    );
  }
}
