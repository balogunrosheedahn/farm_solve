import 'package:farm_solve/pages/home_page.dart';
import 'package:farm_solve/pages/category_page.dart';
import 'package:farm_solve/pages/profile_page.dart';
import 'package:farm_solve/pages/cart_page.dart';
import 'package:flutter/material.dart';


//bottom NavBar Home Categories Cart Profile

class BottomNavController extends StatefulWidget {
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    HomePage(),
    CartPage(),
    CategoryPage(),
    ProfilePage(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
        onTap: (index){
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });

        },

      ),
      body: _pages[_currentIndex],
    );
  }
  
}