
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_streets/Testing/tesing.dart';
import 'package:the_streets/pages/notification_page.dart';
import 'package:the_streets/pages/post_page.dart';
import 'package:the_streets/pages/profile_page.dart';
import 'package:the_streets/pages/testing_page.dart';

import '../pages/homepage.dart';
import '../utils/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget myAppBarF(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      //borderRadius: BorderRadius.all(Radius.circular(15)),
      //color: Colors.red,
      gradient: LinearGradient(
        colors: [Colors.black,Colors.teal],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //SizedBox(height: 90,),
       /* Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20,),
            Text('the',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            Text(' Streets',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
          ],
        ),
        SizedBox(height: 1,),*/
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Spacer(),
            //Icon(Icons.menu,color: Colors.white,),
             GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),
                  Text('the',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  Text(' Streets',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                ],
              ),
               onTap: (){

               },
            ),
            SizedBox(width: 30,),
            Spacer(),
            Text('Feed',style: TextStyle(color: Colors.tealAccent,fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(width: 80,),
            Spacer(),
            IconButton(
              icon: Icon(Icons.search,color: Colors.white,size: 29,),
              onPressed: () {
              },
            ),
            Spacer(),
          ],
        ),
      ],
    ),
  );
}

Widget buildBottomNavigation(BuildContext context) => BottomNavigationBar(
  elevation: 0,
  unselectedItemColor: Colors.tealAccent,
  selectedItemColor: Colors.tealAccent,
  backgroundColor: Colors.transparent,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  items: [
    BottomNavigationBarItem(
      icon: GestureDetector(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').doc("3nQaqlS9pcUYdgTAI6EfbrAxVLX2").snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var userDocument = snapshot.data!;
                var myPic = userDocument["image_url"];
                String myId = FirebaseAuth.instance.currentUser!.uid;
                var users = snapshot.data!.data()?.length;
                // if (!snapshot.hasData) {
                //   return new Text("Loading");
                // }
                return myPic!=null ? CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(myPic),
                  backgroundColor: Colors.teal,
                ) : CircularProgressIndicator();
              }else if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.hasError){
                return CircularProgressIndicator();
              }else{
                return CircularProgressIndicator();
              }
            }
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext _)=>ProfilePage()),);
        },
      ),
      label: '',
    ),

    BottomNavigationBarItem(
      icon: GestureDetector(
        child: Container(
          height: 56,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              // colors: [Colors.black,Colors.teal],
              colors: [Colors.black,Colors.red],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit,color:  Colors.white,size: 19,),
              Text(
                'Post',
                style: TextStyle(color:  Colors.white,fontSize: 21,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext _)=>PostPage()));
        },
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.notifications,color: Colors.teal,size: 29,),
            new Positioned(
              right: -5,
              top: -7,
              //left: 1,
              child: new Container(
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                constraints: BoxConstraints(
                  minWidth: 17,
                  minHeight: 17,
                ),
                child: new Text(
                  '2',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext _)=>NotificationPage()));
        },
      ),
      label: '',
    ),
  ],
);

void showMyDialog(BuildContext context,TextEditingController myController) {
  //showMyDialog(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        //backgroundColor: Colors.teal,
          contentPadding: EdgeInsets.all(0.0),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              //color: Colors.red,
              gradient: LinearGradient(
                colors: [Colors.black, Colors.teal],
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child:
            StatefulBuilder(// You need this, notice the parameters below:
                builder: (BuildContext context, StateSetter setState) {
                  return Wrap(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myButton(Icons.add_circle, 20, 5, 'New Post', 10, 10,
                              10, 10),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            child: myButton(
                                Icons.arrow_left, 14, 5, 'back', 30, 0, 30, 0),
                            onTap: () {
                              myController.text = '';
                              Navigator.pop(context);
                            },
                          ),
                          Spacer(),
                          GestureDetector(
                            child: myButton(
                                Icons.person_pin, 14, 5, 'Me', 0, 30, 0, 30),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ));
    },
  );
}

Widget myButton(
    IconData? myIcon,
    double padVal,
    double margVal,
    String title,
    double tR,
    double tL,
    double bR,
    double bL,
    ) {
  return Container(
    padding: EdgeInsets.all(padVal),
    margin: EdgeInsets.all(margVal),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(tR),
          topLeft: Radius.circular(tL),
          bottomRight: Radius.circular(bR),
          bottomLeft: Radius.circular(bL)),
      //color: Colors.red,
      gradient: LinearGradient(
        colors: [Colors.black, Colors.teal],
      ),
    ),
    child: Row(
      children: [
        Icon(
          myIcon,
          color: Colors.white,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}