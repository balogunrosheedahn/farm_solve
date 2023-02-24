import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Text("Available Products", style: GoogleFonts.raleway(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            ),
            Text("See all", style: GoogleFonts.raleway(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                //margin: EdgeInsets.all(10),
                //padding: EdgeInsets.all(5),
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  boxShadow:[BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                  )]
                ),

              )
            ],
          ),
        )
        
      ],
    );
  }
}
