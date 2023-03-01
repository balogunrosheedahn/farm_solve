import 'package:farm_solve/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(context, CupertinoPageRoute(builder: (_) => HomePage()));
      }
      else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Container(width: 100.00,
                        height: 100.00,
                        child: Center(child: Image.asset("lib/images/farm_logo.png"))),
                    SizedBox(height: 50,),

                  ],

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    "Welcome Back",
                    style: GoogleFonts.raleway(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
            SizedBox(height: 30,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide
                          (color: Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.grey )),
                        hintText: "thefarmer24@gmail.com",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF414041),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide
                          (color: Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.grey )),
                        hintText: "password must be 6 character",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF414041),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // elevated button
                SizedBox(
                  width: 200,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.green,
                      elevation: 3,
                    ),
                  ),
                ),
                Spacer()
              ]
          ),

        )
    );
  }
}