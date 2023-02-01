import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/out_appbar.dart';
import 'homepage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:the_streets/widgets/global_variables.dart';

class FeedBox extends StatefulWidget {
  FeedBox(
      {required this.profImage,
      required this.name,
      required this.role,
      required this.myDate,
      required this.desc,
      required this.views,
      required this.edit,
      required this.docId,
        required this.verified,
        required this.postImage,
      });
  final String profImage;
  final String name;
  final String role;
  final DateTime myDate;
  final String desc;
  final int views;
  final bool edit;
  final String docId;
  final bool verified;
  final String postImage;
  @override
  State<FeedBox> createState() => _FeedBoxState(
      profImage: profImage,
      name: name,
      role: role,
      myDate: myDate,
      desc: desc,
      views: views,
      edit: edit,
      docId: docId,
    verified: verified,
      postImage: postImage,
  );
}

class _FeedBoxState extends State<FeedBox> {
  _FeedBoxState({required this.profImage,
    required this.name,
    required this.role,
    required this.myDate,
    required this.desc,
    required this.views,
    required this.edit,
    required this.docId,required this.verified,required this.postImage});

  final String profImage;
  String postImage;
  final String name;
  final String role;
  final DateTime myDate;
  final String desc;
  final String docId;
  late int views;
  final bool edit;
  final bool verified;
  final repCon = TextEditingController();
  bool isTyped = false;
  //final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    repCon.addListener(() {
      setState(() {
        //isTextFieldEmpty = repCon.text.isEmpty;
        if(repCon.text != ""){
          isTyped = true;
        }
        if(repCon.text == ""){
          isTyped = false;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    repCon.dispose();
    super.dispose();
  }

  TextEditingController editCon = new TextEditingController();
  final Stream<QuerySnapshot> _partiesStream = FirebaseFirestore.instance
      .collection('feeds')
      .orderBy('timeTool', descending: false)
      .snapshots();
  List<String> tMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  DateTime date = DateTime.now();
  String imageLink = "none";
  var myDay = Timestamp.now().toDate().day;
  int myMonth = Timestamp.now().toDate().month;
  var myYear = Timestamp.now().toDate().year;
  var myDtime = Timestamp.now().toDate().hour;
  String nowTime = "${Timestamp.now().toDate().hour} : ${Timestamp.now().toDate().minute}";
  String myUserName = "";
  String myEmail = "";
  String myUserId = "";
  String myPic = "";
  String myOccupation = "";
  String userImageUrl = "";
  bool takeImage = false;
  bool showPostButton = false;
  bool _isLoading = false;
  List<dynamic> likeId = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var statStart = MediaQuery.of(context).padding;
    double statusBar = statStart.top;
    var myWidth2 = MediaQuery
        .of(context)
        .size
        .width;
    var myHeight2 = MediaQuery
        .of(context)
        .size
        .height;
    String dateFormat = DateFormat('EEEE').format(date);
    double myWidth = 80;
    double myHeight = 40;
    editCon.text = desc;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(44.0, 44.0),
        child: OutAppBar(
          title: "$name's post",
          tSize: 13,
          col: Colors.black,
          col2: Colors.teal,
        ),
      ),
      // a message list
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///*********************Start****************************
                  Container(
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
                              backgroundImage: NetworkImage(profImage),
                              radius: 24,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  //"$myHeight2",
                                  style: TextStyle(color: Colors.teal, fontSize: 18),
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
                              ],
                            ),
                            Spacer(),
                            edit
                                ? GestureDetector(
                              child: Container(
                                  height: 36,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    gradient: LinearGradient(
                                      // colors: [Colors.black,Colors.teal],
                                      colors: [Colors.green, Colors.lightGreen],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                          'updating...',
                                          style: TextStyle(color: Colors.indigo),
                                        ),
                                        actions: [
                                          //_pickImage();
                                          Center(
                                            child: LoadingAnimationWidget
                                                .fourRotatingDots(
                                              color: Colors.tealAccent,
                                              size: 80,
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                                await FirebaseFirestore.instance
                                    .collection('feeds')
                                    .doc(docId)
                                    .update({
                                  'desc': editCon.text,
                                });
                                //we code here
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                          'Post Updated Succesfully',
                                          style: TextStyle(color: Colors.indigo),
                                        ),
                                        actions: [
                                          //_pickImage();
                                          MaterialButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext) =>
                                                        HomePage(),
                                                  ));
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                            )
                                : IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.teal,
                              ),
                              onPressed: () {},
                            ),
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
                              '•${timeAgo(myDate)}•',
                              style: TextStyle(color: Colors.red, fontSize: 11),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        edit
                            ? EditableText(
                            controller: editCon,
                            maxLines: 10,
                            focusNode: FocusNode(
                              skipTraversal: true,
                            ),
                            style: TextStyle(color: Colors.blueGrey),
                            cursorColor: Colors.green,
                            backgroundCursorColor: Colors.orange)
                            : Text(
                          desc,
                          style: TextStyle(color: Colors.blueGrey, fontSize: 13),
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
                        edit
                            ? SizedBox(
                          height: 10,
                        )
                            : SizedBox.shrink(),
                        edit ? SizedBox.shrink() : Divider(),
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
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.blueGrey,
                                    ),
                                    Text(
                                      '$views',
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                            Spacer(),
                            Container(
                              width: myWidth,
                              height: myHeight,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat,
                                    color: Colors.blueGrey,
                                  ),
                                  Text(
                                    'Reply',
                                    style:
                                    TextStyle(color: Colors.blueGrey, fontSize: 13),
                                  ),
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
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.blueGrey,
                                  ),
                                  Text(
                                    'share',
                                    style:
                                    TextStyle(color: Colors.blueGrey, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ///*********************End******************************
                  //This is the problem
                  LayoutBuilder(
                      builder: (context, constraints) {
                        // if(myHeight2>600.0){
                        //   return comments(myWidth2,myHeight2,myHeight2-360);
                        // }else if(myHeight2<600.0){
                        //   return comments(myWidth2,myHeight2,myHeight2-340);
                        // }
                        return comments(myWidth2,myHeight2,myHeight2-340);
                      }
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              //color: Colors.teal,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.only(right: 8, left: 8, bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 15 : 28, top: 8),
                child: Container(
                  /// Do not remve this comment Asswhole
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(30)),
                  //     gradient: LinearGradient(
                  //       colors: [Colors.black,Colors.teal],
                  //     )
                  // ),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                IconButton(
                                  splashRadius: 20,
                                  icon: Icon(Icons.add, color: Colors.grey.shade700, size: 28,),
                                  onPressed: () {},
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: TextField(
                                      controller: repCon,
                                      minLines: 1,
                                      maxLines: 5,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.only(right: 16, left: 20, bottom: 10, top: 10),
                                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                                        hintText: 'Type a message',
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          gapPadding: 0,
                                          borderSide: BorderSide(color: Colors.grey.shade200),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          gapPadding: 0,
                                          borderSide: BorderSide(color: Colors.grey.shade300),
                                        ),
                                      ),
                                      onChanged: (value) {

                                      },
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(width: 5,),
                          Row(
                            children: [
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                      .instance.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    var userDocument = snapshot.data!;
                                    myUserName = userDocument["username"];
                                    myEmail = userDocument["email"];
                                    myUserId = userDocument["userId"];
                                    myPic = userDocument["image_url"];
                                    myOccupation = userDocument["occupation"];
                                    userImageUrl = userDocument["image_url"];

                                    if (!snapshot.hasData) {
                                      return SizedBox.shrink();
                                    }
                                    return isTyped ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        // gradient: LinearGradient(
                                        //   colors: [Colors.black,isTyped ? Colors.teal : Colors.grey],
                                        // ),
                                        color: isTyped ? Colors.teal : Colors.black12,
                                      ),
                                      child: IconButton(
                                        splashRadius: 20,
                                        icon: Icon(
                                          Icons.send,
                                          color: Colors.tealAccent,
                                        ),
                                        onPressed: () {
                                          if (repCon.text != "") {
                                            FirebaseFirestore.instance
                                                .collection('feeds')
                                                .doc(docId)
                                                .collection("replies")
                                                .doc()
                                                .set({
                                              'replyText': repCon.text,
                                              'occupation': myOccupation,
                                              'likeId': likeId,
                                              'views': likeId.length,
                                              'userName': myUserName,
                                              'userImageUrl': userImageUrl,
                                              'email': myEmail,
                                              'userId': myUserId,
                                              'myTime':
                                              " $myYear ◦ ${tMonths[myMonth - 1]} ◦ ${myDay} ◦ $dateFormat ~ $nowTime ◦",
                                              'timeTool':
                                              FieldValue.serverTimestamp(),
                                            });
                                            repCon.text = "";
                                          }
                                        },
                                      ),
                                    ) : SizedBox.shrink();
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget comments(double myWidth2,double myHeight2,double listHeight){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('feeds')
          .doc(docId)
          .collection('replies').orderBy('timeTool', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<DocumentSnapshot> documents = snapshot.data!.docs;
        //return Text(documents[index]['field']);

        return Column(
          children: [
            Container(
              //color: Colors.red,
                child: SizedBox(
                  height: listHeight,
                  child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (ctx, index) {
                        String replyText = '${documents[index]['replyText']}';
                        int likes = documents[index]['likeId'].length;
                        String myPic2 = documents[index]['userImageUrl'];
                        String myName2 = documents[index]['userName'];
                        Timestamp myD = documents[index]['timeTool'];
                        //bool verified = documents[index]['verified'];
                        DateTime myDate2 = myD.toDate();
                        return Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage(myPic2),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  //margin: EdgeInsets.all(2),
                                  width: myWidth2 * 0.86,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(5)),
                                    color: Colors.black12,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        myName2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        //"${documents[index].id}",
                                        replyText,
                                        style: TextStyle(
                                            fontWeight: FontWeight
                                                .normal,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: myWidth2 * 0.13,),//
                                //Text("${tMonths[myMonth-1]} ◦ ${myDay} ~ $nowTime ◦",style: TextStyle(fontSize: 10),),
                                Text('•${timeAgo(myDate2)}•',style: TextStyle(fontSize: 10,color: Colors.black),),
                                Text("$likes",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),
                                SizedBox(width: 2,),
                                GestureDetector(
                                  child: Container(child: Text("Like",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: likeId.contains("${FirebaseAuth.instance.currentUser!.uid}") ? Colors.lightBlue : Colors.blueGrey),)),
                                  onTap: (){
                                    print("im pressed *************");
                                    /// Unsolved Problem here plzz *******************************************************************
                                    setState(() {
                                      if(likeId.contains("${FirebaseAuth.instance.currentUser!.uid}")){
                                        FirebaseFirestore.instance
                                            .collection('feeds')
                                            .doc(docId).collection("replies").doc("${documents[index].id}").update({
                                          'likeId': FieldValue.arrayRemove(["${FirebaseAuth.instance.currentUser!.uid}"]),
                                        });
                                      }else{
                                        FirebaseFirestore.instance
                                            .collection('feeds')
                                            .doc(docId).collection("replies").doc("${documents[index].id}").update({
                                          'likeId': FieldValue.arrayUnion(["${FirebaseAuth.instance.currentUser!.uid}"]),
                                        });//${documents[index]['replyText']
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                )),
          ],
        );
      },
    );
  }
}
