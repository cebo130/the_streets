import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:the_streets/pages/testing_page.dart';
import 'package:the_streets/widgets/post_widget.dart';
import '../model/date_time_extension.dart';
import '../widgets/action_sheet.dart';
import '../widgets/homepage_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'feed_box.dart';
import 'package:the_streets/widgets/global_variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _partiesStream = FirebaseFirestore.instance
      .collection('feeds')
      .orderBy('timeTool', descending: false)
      .snapshots();
  //String? userId = FirebaseAuth.instance.currentUser!.uid!;

  double myWidth = 100;
  double myHeight = 33;
  bool isOpen = false;
  int myInt = 5;
  String testStr = 'cebo';
  final loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  double containerHeight = 20.0;
  final myController = TextEditingController();
  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  //String documentID = "";
  // Future<String> myId()async{
  //   var doc_ref = await FirebaseFirestore.instance.collection("feeds").get();
  //   doc_ref.docs.
  //   return documentID;
  // }
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    double myWidth2 = MediaQuery.of(context).size.width;
    double myHeight2 = MediaQuery.of(context).size.height;
    List<Widget> myNo = List.generate(10, (index) {
      return Container(
          width: 200, color: Colors.red, child: Text("comment number $index"));
    });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(44.0, 44.0),
        child: myAppBarF(context),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white, Colors.white],
          ),
        ),
        child: StreamBuilder(
          stream: _partiesStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Text("something is wrong");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.tealAccent,
                  size: 80,
                ),
              );
            } else {
              final chatDocs = snapshot.data.docs!;
              return Container(
                color: Colors.white,
                child: ListView.builder(
                    //reverse: true,
                    itemCount: chatDocs.length,
                    itemBuilder: (ctx, index) {
                      String name = '${chatDocs[index]['userName']}';
                      String role = '${chatDocs[index]['occupation']}';
                      String desc = '${chatDocs[index]['desc']}';
                      String myTime = chatDocs[index]['myTime'];
                      String image = chatDocs[index]['userImageUrl'];
                      List<dynamic> viewId = chatDocs[index]['viewId'];
                      int views = chatDocs[index]['viewId'].length;
                      Timestamp myTimeT = chatDocs[index]['timeTool'];
                      DateTime myDate = myTimeT.toDate();
                      bool verified = chatDocs[index]['verified'];
                      String postImage = chatDocs[index]['postImageUrl'];
                      return Column(
                        children: [
                          Divider(
                            indent: 140,
                            endIndent: 140,
                          ),
                          Container(
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(image),
                                      radius: 24,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: TextStyle(
                                              color: Colors.teal, fontSize: 18),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              role,
                                              //"${timeAgo(myDate)}",
                                              style: TextStyle(
                                                  color: Colors.blue, fontSize: 14),
                                            ),
                                            SizedBox(width: 5,),
                                            verified ? Icon(
                                              Icons.check_circle,
                                              color: Colors.blue,
                                              size: 20,
                                            ) : SizedBox.shrink(),
                                          ],
                                        ),
                                        //Text('•',style: TextStyle(color: Colors.blueGrey,fontSize: 14),),
                                        // Row(
                                        //   children: [],
                                        // ),
                                      ],
                                    ),
                                    Spacer(),
                                    FirebaseAuth.instance.currentUser!.uid == chatDocs[index]['userId'] ? PopupMenuButton<int>(
                                      itemBuilder: (context) => [
                                        // popupmenu item 1
                                        PopupMenuItem(
                                          value: 1,
                                          child: GestureDetector(
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit,color: Colors.teal,),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("Edit",style: TextStyle(color: Colors.teal),)
                                              ],
                                            ),
                                            onTap: (){
                                             setState(() {
                                               print("This button is to edit and update shit on the database bitch !!");
                                               edit = true;
                                               Navigator.push(
                                                   context,
                                                   MaterialPageRoute(
                                                       builder: (BuildContext _) =>
                                                           FeedBox(
                                                             profImage: image,
                                                             name: name,
                                                             role: role,
                                                             myDate:myDate,
                                                             desc: desc,
                                                             views: views,
                                                             edit: edit,
                                                             docId: "${chatDocs[index].id}",
                                                             verified: verified,
                                                             postImage: postImage,
                                                           )));
                                             });
                                            },
                                          ),
                                        ),
                                        // popupmenu item 2
                                        PopupMenuItem(
                                          value: 2,
                                          // row has two child icon and text
                                          child: GestureDetector(
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete_forever,color: Colors.red,),
                                                SizedBox(
                                                  // sized box with width 10
                                                  width: 10,
                                                ),
                                                Text("Delete",style: TextStyle(color: Colors.red),)
                                              ],
                                            ),
                                            onTap: ()async{
                                              // This is how you Delete a document with automated doc id, in a listview, or one you do not know its doc id
                                              await FirebaseFirestore.instance.collection("feeds").doc(chatDocs[index].id).delete().then(
                                                    (doc) => print(chatDocs[index].id),
                                                onError: (e) => print("Error updating document $e"),
                                              );
                                              // End
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                      offset: Offset(-20, 60),
                                      color: Colors.white,
                                      elevation: 2,
                                    ) : SizedBox.shrink(),
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
                                    Text(
                                     // '• ${getVerboseDateTimeRepresentation(my_time.toDate())} •',
                                     // myTime,
                                      "•${timeAgo(myDate)}•",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12,fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //FirebaseAuth.instance.currentUser!.uid == chatDocs[index]['userId'] ?
                                Text(
                                  desc,
                                  //viewId.contains("${FirebaseAuth.instance.currentUser!.uid}") ? "yes it has it" : "no its not here",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 15),
                                ),
                                if(postImage != "") Divider(),
                                if(postImage != "") Container(
                                  width: myWidth2-10,
                                  child: Image(
                                    image: NetworkImage(postImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                            border: Border.all(
                                                color: viewId.contains("${FirebaseAuth.instance.currentUser!.uid}") ? Colors.lightBlue : Colors.blueGrey,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              viewId.contains("${FirebaseAuth.instance.currentUser!.uid}") ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                                              color: viewId.contains("${FirebaseAuth.instance.currentUser!.uid}") ? Colors.lightBlue : Colors.blueGrey,
                                            ),
                                            Text(
                                              '$views',
                                              style: TextStyle(
                                                  color: viewId.contains("${FirebaseAuth.instance.currentUser!.uid}") ? Colors.lightBlue : Colors.blueGrey,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        //Start*********************
                                        if(viewId.contains("${FirebaseAuth.instance.currentUser!.uid}")){
                                          FirebaseFirestore.instance
                                              .collection('feeds')
                                              .doc('${chatDocs[index].id}')
                                              .update({
                                            'viewId': FieldValue.arrayRemove(["${FirebaseAuth.instance.currentUser!.uid}"]),
                                          });
                                        }else{
                                          FirebaseFirestore.instance
                                              .collection('feeds')
                                              .doc('${chatDocs[index].id}')
                                              .update({
                                            'viewId': FieldValue.arrayUnion(["${FirebaseAuth.instance.currentUser!.uid}"]),
                                          });
                                        }
                                        //end****************************
                                      },
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      child: Container(
                                        width: myWidth,
                                        height: myHeight,
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.chat,
                                              color: Colors.blueGrey,
                                            ),
                                            Text(
                                              'Reply',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        edit = false;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext _) =>
                                                    FeedBox(
                                                      profImage: image,
                                                      name: name,
                                                      role: role,
                                                      myDate: myDate,
                                                          /*getVerboseDateTimeRepresentation(
                                                              my_time.toDate()),*/
                                                      desc: desc,
                                                      views: views,
                                                      edit: edit,
                                                      docId: "${chatDocs[index].id}",
                                                      verified: verified,
                                                      postImage: postImage,
                                                    )));
                                      },
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      child: Container(
                                        width: myWidth,
                                        height: myHeight,
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.share,
                                              color: Colors.blueGrey,
                                            ),
                                            Text(
                                              'share',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: (){},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: buildBottomNavigation(context),
    );
  }

}
