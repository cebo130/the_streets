import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:the_streets/pages/homepage.dart';
import 'package:the_streets/widgets/pickers/post_image.dart';

import '../../widgets/pickers/user_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  final nameCon = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    nameCon.dispose();
    super.dispose();
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
  ///Ending****************
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Create Profile",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.lock,
                    color: Colors.grey,
                    size: 40,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Secure",
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Party Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PostImage(_pickedImage),
                SizedBox(
                  width: 10,
                ),
                inputText('party_name', 'Name of party', partyName.text, 150,
                    partyName),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.indigo,
                      Colors.black,
                    ],
                  ),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  //color: myCol, //Change here***********************//
                ),
                padding: const EdgeInsets.all(8),
                width: 150,
                height: 60,
                child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: Text('adding party...',style: TextStyle(color: Colors.indigo),),
                        actions: [
                          //_pickImage();
                          Center(child: CircularProgressIndicator(color: Colors.indigo,)),
                        ],
                      );
                    }
                );
                //here
                //Start*********************
                if(pImageFile != null){
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child('images')
                      .child(partyName.text + getRandomString(5) + '.jpg');
                  await ref
                      .putFile(pImageFile!)
                      .whenComplete(() => print('Uploading party Image Done'));
                  myPostImageUrl = await ref.getDownloadURL();
                }else{
                  myPostImageUrl = "";
                }
                //myPostImageUrl = url1;
                ///database
                FirebaseFirestore.instance
                    .collection('cebo')
                    .doc('${partyName.text}')
                    .set({
                  'postImageUrl': myPostImageUrl,
                });
                //End************************
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: Text('url is $myPostImageUrl',style: TextStyle(color: Colors.indigo),),
                        actions: [
                          //_pickImage();
                          MaterialButton(
                            child: Text('Ok'),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>HomePage()));
                            },
                          ),
                        ],
                      );
                    }
                );
              },
            ),
            pImageFile == null ? Text("im empty2") : Text("im full"),
          ],
        ),
      ),
    );
  }

  Widget inputText(String myKey, String Name, String myController,
      double myWidth, TextEditingController myCon) {
    return Container(
      width: myWidth,
      child: TextFormField(
        controller: myCon,
        key: ValueKey(myKey),
        validator: (value) {
          if (value!.isEmpty) {
            return 'please enter $Name';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          // fillColor: Colors.tealAccent,
          //   filled: false,
            focusColor: Colors.teal,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            isDense: true,
            labelText: '$Name',
            hintText: '',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelStyle: const TextStyle(fontSize: 16),
            labelStyle: const TextStyle(fontSize: 13, color: Colors.teal)),
        onSaved: (value) {
          myController = value!;
        },
      ),
    );
  }
}
