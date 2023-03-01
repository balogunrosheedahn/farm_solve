import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("lib/images/avatar.png"))),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Damilola",
                style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "damiofgroup22@gmail.com",
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
              ProfileListWidget(title: 'Edit Profile', icon: Icons.edit),
              ProfileListWidget(title: 'Inbox', icon: Icons.inbox),
              ProfileListWidget(title: 'Order History', icon: Icons.history),
              ProfileListWidget(title: 'Help', icon: Icons.help),
              Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileListWidget(title: 'Logout', icon: Icons.logout),
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
      leading: Icon(
        icon,
        color: Colors.grey.shade600,
        size: 20,
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
