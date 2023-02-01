import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_streets/pages/auth_pages/auth_page.dart';

class OutAppBar extends StatefulWidget {
  OutAppBar({required this.title,required this.tSize,required this.col,required this.col2});
  final String title;
  final double tSize;
  final Color col;
  final Color col2;
  @override
  State<OutAppBar> createState() => _OutAppBarState(title: title,tSize: tSize,col: col,col2: col2);
}

class _OutAppBarState extends State<OutAppBar> {
  _OutAppBarState({required this.title,required this.tSize,required this.col,required this.col2});
  final String title;
  final double tSize;
  final Color col;
  final Color col2;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(15)),
        //color: Colors.red,
        gradient: LinearGradient(
          // colors: [Colors.black,Colors.teal],
          colors: [col,col2],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Spacer(),
              //Icon(Icons.menu,color: Colors.white,),
              IconButton(
                icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: (){
                  // FirebaseAuth.instance.signOut();
                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AuthPage()));
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 30,),
              Spacer(),
              Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: tSize),),
              SizedBox(width: 80,),
              Spacer(),

            ],
          ),
        ],
      ),
    );
  }
}
