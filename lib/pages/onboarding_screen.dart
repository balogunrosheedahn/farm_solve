import 'package:farm_solve/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class onboardingScreen extends StatelessWidget {
  const onboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80, bottom: 40, top: 160 ),
            child: Image.asset("assets/images/eggs.jpg"),
          ),
         //We deliver fresh farm produce at your doorstep
           Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text("We deliver fresh farm produce at your doorstep",
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            )),
          ),
          const SizedBox(height: 24,),
          //Bridging the farmer's and consumer
          Text("Bridging the farmer's and consumer",
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const Spacer(),
          //get started button
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context){
            return HomePage();
                }
                )),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                      borderRadius: BorderRadius.circular(12)
                ),
                padding: const EdgeInsets.all(24.0),
                child: const Text("Get Started",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),),
              ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
