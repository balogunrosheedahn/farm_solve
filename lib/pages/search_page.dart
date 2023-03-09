import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_solve/items/product_item.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                    print(inputText);
                  });
                },
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .where("product-name",
                        isGreaterThanOrEqualTo: inputText)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Something went wrong"),
                        );
                      }
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> data =
                          snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductItem(data),
                              ),
                            ),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                title: Text(data['product-name']),
                                leading: Image.network(data['product-img']),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
