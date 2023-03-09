import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-cart-items")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something is wrong"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<Widget> itemsList = snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
              Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

              int quantity = data['quantity'] ?? 1;
              int price = data['price'] ?? 0;
              int total = quantity * price;

              return Card(
                elevation: 5,
                child: ListTile(
                  leading:  Text(
                    data['name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "\₦ $price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Quantity: $quantity",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Total: \₦ $total",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellowAccent.shade700),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.green.shade600,
                          ),
                        ),
                        onTap: () {
                          if (quantity == 1) {
                            FirebaseFirestore.instance
                                .collection("users-cart-items")
                                .doc(FirebaseAuth.instance.currentUser!.email!)
                                .collection("items")
                                .doc(documentSnapshot.id)
                                .delete();
                          } else {
                            FirebaseFirestore.instance
                                .collection("users-cart-items")
                                .doc(FirebaseAuth.instance.currentUser!.email!)
                                .collection("items")
                                .doc(documentSnapshot.id)
                                .update({'quantity': quantity - 1});
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.green.shade600,
                          ),
                        ),
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("users-cart-items")
                              .doc(FirebaseAuth.instance.currentUser!.email!)
                              .collection("items")
                              .doc(documentSnapshot.id)
                              .update({'quantity': quantity + 1});
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList();

            double total = snapshot.data!.docs.fold(
              0,
                  (previousValue, element) =>
              previousValue +
                  (element['quantity'] ?? 1) *
                      (element['price'] ?? 0),
            );

            itemsList.add(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total: \₦ $total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            );

            return ListView(
              children: itemsList,
            );



          },
    ),
    ),
);
}
}
