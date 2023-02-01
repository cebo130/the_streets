import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_streets/pages/homepage.dart';
import 'package:the_streets/widgets/out_appbar.dart';
import 'package:intl/intl.dart';
import 'package:the_streets/widgets/pickers/post_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ///start
  ///end
  final descCon = TextEditingController();
  // final partyName = TextEditingController();
  // String? imageName = "";
  // String? lastThree = "";
  // File? pImageFile;
  // void _pickedImage(File image) {
  //   pImageFile = image;
  //   imageName = pImageFile!.toString();
  //   int index=imageName!.lastIndexOf('.')+1;
  //   lastThree = imageName!.substring(index,imageName!.length);
  // }

  bool isTyped = false;
  //final TextEditingController textEditingController = TextEditingController();
  bool addImage = false;
  @override
  void initState() {
    super.initState();
    descCon.addListener(() {
      setState(() {
        //isTextFieldEmpty = repCon.text.isEmpty;
        if(descCon.text != ""){
          isTyped = true;
        }
        if(descCon.text == ""){
          isTyped = false;
        }
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    descCon.dispose();
    super.dispose();
  }
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
  var myDay = Timestamp.now().toDate().day;
  int myMonth = Timestamp.now().toDate().month;
  var myYear = Timestamp.now().toDate().year;
  var myDtime = Timestamp.now().toDate().hour;
  String nowTime = "${Timestamp.now().toDate().hour} : ${Timestamp.now().toDate().minute}";
  String myUserName = "";
  String myEmail = "";
  String myUserId = "";
  bool verified = false;
  String myPic = "";
  //String postImageUrl = "";

  List<dynamic> viewId = [];
  String myOccupation = "";
  String userImageUrl = "";
  bool takeImage = false;
  bool showPostButton = false;
  bool _isLoading = false;
  void _uploadData(String dateFormat) async {
    setState(() {
      _isLoading = true;
    });
  //  FirebaseFirestore.instance
       // .collection('feeds')
       // .doc()
       // .set({
      //'image_url1': imageLink,
      // 'desc': descCon.text,
      // 'occupation': myOccupation,
      // 'viewId': viewId,
      // 'views': 0,
      // 'userName':myUserName,
      // 'userImageUrl': userImageUrl,
      // 'email' : myEmail,
      // 'userId': myUserId,
      // 'myTime':  " $myYear ◦ ${tMonths[myMonth-1]} ◦ ${myDay} ◦ $dateFormat ~ $nowTime ◦",
      // 'timeTool': FieldValue.serverTimestamp(),
      // 'verified': verified,
      //'postImageUrl': "",//postImageUrl,
    //});

    // setState(() {
    //   _isLoading = false;
    // });
  }
  ///Start****************
  final partyName = TextEditingController();
  bool isPressed = false;
  File? pImageFile;
  String col = 'green';
  void _pickedImage(File image) {
    pImageFile = image;
  }
  String userId = FirebaseAuth.instance.currentUser!.uid;
  bool done = false;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String getRandomString2(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String myPostImageUrl = "";
  ///Ending****************\
  bool uploaded = false;
  @override
  Widget build(BuildContext context) {
    if(descCon.text!=""){
      setState(() {
        showPostButton = true;
      });
    }
    if(descCon.text==""){
      setState(() {
        showPostButton = false;
      });
    }
    String dateFormat = DateFormat('EEEE').format(date);
    var myWidth = MediaQuery.of(context).size.width;
    var myHeight = MediaQuery.of(context).size.height-100;
    int max = 5;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(44.0, 44.0),
        child: OutAppBar(title: "Create Post",tSize: 20,col:Colors.black,col2: Colors.red,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            //Used Start ***
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  var userDocument = snapshot.data!;
                  myUserName = userDocument["username"];
                  myEmail = userDocument["email"];
                  myUserId = userDocument["userId"];
                  myPic = userDocument["image_url"];
                  myOccupation = userDocument["occupation"];
                  userImageUrl = userDocument["image_url"];
                  verified = userDocument["verified"];
                  if (!snapshot.hasData) {
                    return SizedBox.shrink();
                  }
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 27,
                          backgroundImage: NetworkImage(myPic),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myUserName,
                              style: TextStyle(color: Colors.blueGrey,fontSize: 20),
                            ),
                            Text(
                              myOccupation,
                              style: TextStyle(color: Colors.red,fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
            ),
            //used End
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                Container(
                  padding: EdgeInsets.all(6),
                  // margin: EdgeInsets.all(5),
                  child: Text(
                    "$dateFormat",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                //SizedBox(width: 1,),
                Container(
                  //padding: EdgeInsets.all(6),
                  // margin: EdgeInsets.all(5),
                  child: Text(
                    "~ ${myDay} ◦ ${tMonths[myMonth-1]} ◦ $myYear",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: myWidth-5,
              child: TextFormField(
                controller: descCon,
                maxLines: max,
                //key: ValueKey(myKey),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter something';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  // fillColor: Colors.tealAccent,
                  //   filled: false,
                    focusColor: Colors.teal,
                    border: InputBorder.none,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    isDense: true,
                    label: Center(
                      child: Text('what do u want to talk about today...'),
                    ),
                    hintText: '',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    floatingLabelStyle: const TextStyle(fontSize: 16),
                    labelStyle: const TextStyle(fontSize: 13, color: Colors.blueGrey)),
                onSaved: (value) {
                  descCon.text = value!;

                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: (){
                    setState(() {
                      takeImage=!takeImage;
                    });
                  },
                  icon: Icon(Icons.add_circle,size: 20,color: Colors.red,),
                ),
                takeImage ? PostImage(_pickedImage) : SizedBox.shrink(),
              ],
            ),
            isTyped ? GestureDetector(
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.tealAccent,
                  gradient: isTyped ? LinearGradient(
                    colors: [Colors.green,Colors.green],
                  ) : LinearGradient(
                    colors: [Colors.black,Colors.red],
                  ),
                ),
                child: Center(
                  child: _isLoading ? CircularProgressIndicator() : Text(
                    "Post",
                    style: TextStyle(color: Colors.white,fontSize: 20),
                  ),
                ),
              ),
              onTap: ()async{
                if(uploaded != true) showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: Text('posting...',style: TextStyle(color: Colors.indigo),),
                      );
                    }
                );
                //Start*********************
                if(pImageFile != null){
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child('post_images')
                      .child(descCon.text + getRandomString(5) + '.jpg');
                  await ref
                      .putFile(pImageFile!)
                      .whenComplete(() => print('Uploading Image Done /** ***********'));
                  myPostImageUrl = await ref.getDownloadURL();
                }else{
                  myPostImageUrl = "";
                }
                //myPostImageUrl = url1;
                ///database
                await FirebaseFirestore.instance
                    .collection('feeds')
                    .doc()
                    .set({
                  'postImageUrl': myPostImageUrl,
                  'desc': descCon.text,
                  'occupation': myOccupation,
                  'viewId': viewId,
                  'views': 0,
                  'userName':myUserName,
                  'userImageUrl': userImageUrl,
                  'email' : myEmail,
                  'userId': myUserId,
                  'myTime':  " $myYear ◦ ${tMonths[myMonth-1]} ◦ ${myDay} ◦ $dateFormat ~ $nowTime ◦",
                  'timeTool': FieldValue.serverTimestamp(),
                  'verified': verified,
                }).whenComplete(() {
                setState(() {
                  uploaded = true;
                });
                });
                //End************************
                if(uploaded == true) Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
              },
            ) : SizedBox.shrink(),
            // Text("$postImageUrl"),
            // Text("${userImageFile.toString()}"),
          ],
        ),
      ),
    );
  }
}
