import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  final CollectionReference notificationCollection = FirebaseFirestore.instance.collection('notification');
  addNotification()async{
    await notificationCollection
        .add({'title': 'New Notification', 'body': 'This is a test notification'});
  }



  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String title = "";
  String notificationAlert = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
        setState(() {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          title = message as String;
          notificationAlert = "New Notification Alert";
        });

      },);
      FirebaseMessaging.onMessageOpenedApp.listen ((message) async{
        setState(() {
          title = message as String;
          notificationAlert = "Application opened from Notification";
        });

      },
      );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final notifications = snapshot.data!.docs;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                title: Text(notification['title']),
                subtitle: Text(notification['content']),
              );
            },
          );
        },
      ),
    );
  }
}
