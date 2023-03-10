
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name = "";
  String? email = "";
  String? image = "";
  File? imageFile;

  var _firestoreInstance = FirebaseFirestore.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  // Future _addDataFromDatabase () async
  // {
  //   await FirebaseFirestore.instance.collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid);
  //   setState(() {
  //     usersCollection.add({
  //       "name": ["name"],
  //       "email": ["email"],
  //       "image":["user-img"],
  //     });
  //   });
  //
  // }
  Future _getDataFromDatabase () async
  {
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
    .get()
    .then((snapshot) async{
      if(snapshot.exists){
    setState(() {
        name= snapshot.data()!["name"];
        email=snapshot.data()! ["email"];
        image = snapshot.data()!["user-img"];

    });
      }});

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_addDataFromDatabase ();
    _getDataFromDatabase ();
  }

  Widget _buildProfileImage() {
    if (imageFile != null) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: Image.file(imageFile!).image,
      );
    } else if (image != null && image!.isNotEmpty) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(image!),
      );
    } else {
      return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.green.shade700,
        child: Icon(Icons.person, size: 50),
      );
    }
  }

  void _logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.raleway(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                  width: 120,
                  height: 120,
                  child: GestureDetector(onTap: (){},
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                      child: _buildProfileImage(),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                'The Farmer',
                style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "thefarmer24@gmail.com",
                style: GoogleFonts.raleway(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileListWidget(title: 'Edit Profile', icon: Icons.edit, ),
              ProfileListWidget(title: 'Inbox', icon: Icons.inbox),
              ProfileListWidget(title: 'Order History', icon: Icons.history),
              ProfileListWidget(title: 'Help', icon: Icons.help),
              Divider(),
              const SizedBox(
                height: 10,
              ),
          GestureDetector(
            onTap: () => _logOut(),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.grey.shade600,
                size: 20,
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.raleway(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
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

class ProfileListWidget extends StatelessWidget {
  const ProfileListWidget({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: (){},
        child: Icon(
          icon,
          color: Colors.grey.shade600,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.raleway(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
