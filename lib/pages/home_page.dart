import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:farm_solve/data/app_colors.dart';
import 'package:farm_solve/items/product_item.dart';
import 'package:farm_solve/pages/cart_page.dart';
import 'package:farm_solve/pages/category_page.dart';
import 'package:farm_solve/pages/profile_page.dart';
import 'package:farm_solve/pages/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart';

class HomePage extends StatefulWidget {

   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final _pages = [
    Home(),
    CategoryPage(),
    CartPage(),
    ProfilePage(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
    child: Center(
    child: _pages[_selectedIndex],
    ),
    ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            elevation: 5,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,

            iconSize: 24,
            items:  [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: ("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: ("Categories"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart,),
                label: ("Cart"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: ("Profile"),
              )
            ],
            onTap:  (int index){
              setState(() {
                _selectedIndex = index;
                print(_pages[_selectedIndex],);
              });
            },

          ),

        );

  }

}
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<String> _carouselImages = [];
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  var _dotPosition = 0;
  TextEditingController textController = TextEditingController();

  fetchCarouselImages() async {
    QuerySnapshot qn = await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(qn.docs[i]["image"]);
        print(qn.docs[i]["image"]);
      }
    });
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "price": qn.docs[i]["price"],
          "product-img": qn.docs[i]["product-img"],
          "quantity": qn.docs[i]["quantity"],
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCarouselImages();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('lib/images/farmer.jpg'),
                      ),
                    ),
                    Text(
                      "Hello Francesca!",
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Badge(
                          badgeContent: Text(
                            "3",
                            style: TextStyle(color: Colors.white),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.notification_important,
                                size: 24,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              searchBox(),
              SizedBox(
                height: 10,
              ),
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                  items: _carouselImages
                      .map(
                        (item) => Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(item), fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
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



    Padding(
    padding: const EdgeInsets.only(left:10 , right:10 , top:20 , bottom: 5),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text("Available Products",
    style: GoogleFonts.raleway(
    fontWeight: FontWeight.bold,
    fontSize: 20,),
    ),
    Text("View all",
    style: GoogleFonts.raleway(color: Colors.green,
    fontSize: 16,
    fontWeight: FontWeight.bold),
    )

    ]
    ),
    ),

          //Available products items+ row grid
          SizedBox(
         height: 15,
           ),
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
          ]
        ),
    ),
    ),);
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