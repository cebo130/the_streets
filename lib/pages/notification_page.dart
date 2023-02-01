import 'package:flutter/material.dart';

import '../widgets/out_appbar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(44.0, 44.0),
        child: OutAppBar(title: "Notification",tSize: 20,col:Colors.black,col2: Colors.teal,),
      ),
      body: Center(
        child: Text("This is where u will see your notifications"),
      ),
    );
  }
}
