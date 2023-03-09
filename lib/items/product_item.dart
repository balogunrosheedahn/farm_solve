import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_solve/pages/cart_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItem extends StatefulWidget {
  final Map<String, dynamic> _product;
  ProductItem(this._product);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late Map<String, dynamic> _product;

  @override
  void initState() {
    super.initState();
    _product = widget._product;
  }

  void addToCart() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-cart-items");
    _collectionRef.doc(currentUser!.email).collection("items").doc().set(
        {
          "name": _product["product-name"],
          "price": _product["price"],
          "images": _product["product-img"],
          "quantity": _product["quantity"],
        }).then((value) {
      Fluttertoast.showToast(
          msg: "Added to Cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green[600],
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Failed to add item to cart. Please try again later.",
          backgroundColor: Colors.red,
          textColor: Colors.white);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:  Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.green,
            child: IconButton(
              onPressed: ()=> Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 3.5,
                  child: CarouselSlider(
                    items: _product['product-img'].split(',')
                        .map<Widget>((item) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(item),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _product['product-name'],
                  style: GoogleFonts.raleway(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),
                Text(
                  "₦ ${_product["price"].toStringAsFixed(2)}",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "In stock: ${_product["quantity"]}",
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 15,),
                Text(
                  _product['product-description'],
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

            Spacer(),

            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                onPressed: ()=> addToCart(),
                child: Text(
                  "Add to Cart",
                  style: GoogleFonts.raleway(
                      color: Colors.white, fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 3,
                ),
              ),
            ),
                Spacer(),
          ],
        ),
      )),
    );
  }
}
