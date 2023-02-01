import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Item {
  Item({
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
});
  String headerText;
  String expandedText;
  bool isExpanded;
}
Widget postWidget(String image,String name, String role,String desc,int views,BuildContext context){
  double myWidth = 100;
  double myHeight = 33;
  List<Item> _data = List<Item>.generate(
    10,
      (int index){
      return Item(
        headerText: 'Item $index',
        expandedText: 'This is item number $index',
      );
      }
  );
  return Container(
    margin: EdgeInsets.all(3),
    padding: EdgeInsets.all(7),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      color: Colors.white,
    ),
    child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 24,
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,style: TextStyle(color: Colors.teal,fontSize: 18),),
                Text(role,style: TextStyle(color: Colors.red,fontSize: 14),),
                //Text('•',style: TextStyle(color: Colors.blueGrey,fontSize: 14),),

                Row(
                  children: [

                  ],
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.more_vert,color: Colors.teal,),
              onPressed: (){},
            )
          ],
        ),
        Divider(
          indent: 5,
          endIndent: 290,
          color: Colors.blueGrey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('• 21/02/2011 •',style: TextStyle(color: Colors.blueGrey,fontSize: 14),),
          ],
        ),
        SizedBox(height: 10,),
        Text(desc,style: TextStyle(color: Colors.blueGrey,fontSize: 13),),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                width: myWidth,
                height: myHeight,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.remove_red_eye,color: Colors.blueGrey,),
                    Text('$views',style: TextStyle(color: Colors.blueGrey,fontSize: 13),),
                  ],
                ),
              ),
              onTap: (){
                //Start*********************
                views=views+1;
                FirebaseFirestore.instance
                    .collection('feeds')
                    .doc('csLAl2gEaX5o48Rc4mfO')
                    .update({
                  'views': views,
                });
                //end****************************
                print('I am click bro relax**********************');
              },
            ),
            Spacer(),
            Container(
              width: myWidth,
              height: myHeight,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat,color: Colors.blueGrey,),
                  Text('Reply',style: TextStyle(color: Colors.blueGrey,fontSize: 13),),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: myWidth,
              height: myHeight,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share,color: Colors.blueGrey,),
                  Text('share',style: TextStyle(color: Colors.blueGrey,fontSize: 13),),
                ],
              ),
            ),
          ],
        ),
        //here
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded){

          },
          children: [
            ExpansionPanel(
              headerBuilder: (context, isOpen){
                return Text('share',style: TextStyle(color: Colors.blueGrey,fontSize: 13),);
              },
              body: Text('share',style: TextStyle(color: Colors.blueGrey,fontSize: 13),),
            ),
          ],
        )
      ],
    ),
  );
}