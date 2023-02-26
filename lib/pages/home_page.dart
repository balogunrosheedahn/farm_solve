import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:farm_solve/data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart';

import '../items/category_item.dart';

class HomePage extends StatefulWidget {

   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();

}

class HomePageState extends State<HomePage> {



  List<String> _carouselImages =[];
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  var _dotPosition = 0;
  TextEditingController textController = TextEditingController();

  fetchCarouselImages() async{
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("carousel-slider").get();
    setState(() {


    for(int i =0; i<qn.docs.length; i++){
      _carouselImages.add(
        qn.docs[i]["image"]
      );
      print(qn.docs[i]["image"]);

    }
    });
    return qn.docs;
  }

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
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
        child: Column(
          children: [
            // avatar
            SizedBox( height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('lib/images/farmer.jpg'),
                    ),
                  ),
                  Text("Hello Francesca!", style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold, fontSize: 16,),),
                  Container(

                    child: Badge(
                      //badgeStyle: Colors.redAccent,
                      //padding: EdgeInsets.all(7.0),
                      badgeContent: Text("3", style: TextStyle(color: Colors.white),),
                      child: InkWell(
                        onTap: (){},
                          child: Padding(
                            padding:  EdgeInsets.all(16.0),
                            child: Icon(
                                Icons.notification_important,
                            size: 24,
                            color: Colors.green,),
                          )
                      ),
                    ),
                  ),

                ],
              ),
            ),
            //Hello Francesca!

            //notification icon
            //divider
            //search feature
            searchBox(),
            // image container
            
            SizedBox(
              height: 10,
            ),
            AspectRatio(aspectRatio: 3.5,
            child: CarouselSlider(items:_carouselImages.map((item) =>Padding(
              padding: const EdgeInsets.only(left: 3.0, right: 3.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(item), fit: BoxFit.fitWidth)
                ),
              ),
            )).toList(), options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (val, carouselPageChangedReason){
                setState(() {
                  _dotPosition = val;
                });
              }
            ),
              
            ),
            ),
            SizedBox(height: 10,),
            DotsIndicator(dotsCount: _carouselImages.length==0?1:_carouselImages.length,
            position: _dotPosition.toDouble(),
            decorator: DotsDecorator(
              activeColor: Colors.green,
              color: Colors.green.withOpacity(0.5),
              spacing: EdgeInsets.all(2),
              activeSize: Size(8 ,8),
              size: Size(6,6),
            ),
            ),


            //Available products items+ row grid
          SizedBox(
            height: 15,
          ),
           Expanded(
              child: SizedBox(
                height: 150,
                width: 100,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1),
                    itemBuilder: (_,index){
                      return Card(
                        elevation: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //AspectRatio(aspectRatio: 2,child: Container(
                              //  color: Colors.yellow,
                            //  child:)),
                            Image.network(_products[index]["product-img"][0],),
                            Text("${_products[index]["product-name"]}"),
                            Text("${_products[index]["price"].toString()}"),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
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
          )

      ),
    );
  }
}
