import 'dart:async';

import 'package:farm_solve/pages/home_page.dart';
import 'package:farm_solve/pages/reg_page.dart';
import 'package:farm_solve/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 80 ),
            child: Image.asset("lib/images/farmgirl.png"),
          ),
         //We deliver fresh farm produce at your doorstep
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Welcome to FarmSolve",
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            )),
          ),
          const SizedBox(height: 12,),
          //Bridging the farmer's and consumer
          Text("Buy and Sell fresh farm produce with ease, \n ranging from fresh to livestock.",
            textAlign: TextAlign.center, style: GoogleFonts.raleway(color: Colors.grey.shade800),
          ),
          const SizedBox(height: 50,),
          //get started button
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context){
            return SignUp();
                }
                )),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                      borderRadius: BorderRadius.circular(12)
                ),
                padding: const EdgeInsets.all(24.0),
                child:  Text("Get Started",
                  style: GoogleFonts.raleway(color: Colors.white, fontSize: 18.0),),
              ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
