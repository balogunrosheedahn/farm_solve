import 'package:farm_solve/pages/home_page.dart';
import 'package:farm_solve/pages/reg_page.dart';
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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _confirmObscureText = true;

  signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => SignIn()));
      } else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "The password provided is too weak.",
            gravity: ToastGravity.CENTER);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg:
            "The account already exists for that email.",
            gravity: ToastGravity.CENTER);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Column(children: [
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
            width: 100.00,
            height: 100.00,
            child:
            Center(child: Image.asset("lib/images/farm_logo.png"))),
        SizedBox(
          height: 50,
        ),
      ],
    ),
    Padding(
    padding: const EdgeInsets.only(left: 4.0),
    child: Text(
    "Sign Up",
    style: GoogleFonts.raleway(
    fontSize: 24,
    color: Colors.black,
    fontWeight: FontWeight.bold),
    textAlign: TextAlign.left,
    ),
    ),
    SizedBox(
    height: 30,
    ),
         Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
           child: TextField(
               controller: _nameController,
              obscureText: false,
              decoration: InputDecoration(
                 enabledBorder: OutlineInputBorder(
                     borderSide:
                     BorderSide(color: Colors.grey.shade300)),
               focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.grey)),
                 hintText: "Full Name",
                 hintStyle: GoogleFonts.raleway(
                  fontSize: 14,
                  color: Color(0xFF414041),
                ),
                 labelText: 'Name',
                 labelStyle: GoogleFonts.raleway(
                  fontSize: 15,
                   color: Colors.grey.shade600,
                 ),
              ),
            ),
          ),
         ),
    //
    Expanded(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
    controller: _emailController,
    obscureText: false,
    decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.grey.shade300)),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey)),
    hintText: "thefarmer24@gmail.com",
    hintStyle: GoogleFonts.raleway(
    fontSize: 14,
    color: Color(0xFF414041),
    ),
    labelText: 'Email',
    labelStyle: GoogleFonts.raleway(
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
    enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.grey.shade300)),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey)),
    hintText: "password must be 6 characters",
    hintStyle: TextStyle(
    fontSize: 14,
      color: Colors.grey.shade600,
    ),
    ),
    ),
    ),
    ),
    // Expanded(
    // child: Padding(
    // padding: const EdgeInsets.symmetric(horizontal: 20),
    // child: TextField(
    // controller: _confirmPasswordController,
    // obscureText: _confirmObscureText,
    // decoration: InputDecoration(
    // enabledBorder: OutlineInputBorder(
    // borderSide:
    // BorderSide(color: Colors.grey.shade300)),
    // focusedBorder: OutlineInputBorder(
    // borderSide: BorderSide(color: Colors.grey)),
    // hintText: "confirm password",
    // hintStyle: GoogleFonts.raleway(
    // fontSize: 14,
    // color: Colors.grey.shade600,
    // ),
    // ),
    // ),
    // ),
    // ),
        SizedBox(
          height: 15,
        ),
        // elevated button
        SizedBox(
          width: 200,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              signUp();
            },
            child: Text(
              "Sign Up",
              style: GoogleFonts.raleway(
                  color: Colors.white, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.green,
              elevation: 3,
            ),
          ),
        ),
        SizedBox(height: 30),
        TextButton(onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => SignIn()),),
            child: Text("Already Have an Account? Sign In",
              style: GoogleFonts.raleway(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),))
      ]
      ),

      )
    );
  }
}
