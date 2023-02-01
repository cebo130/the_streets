import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../widgets/pickers/user_image.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  //final nameCon = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    //nameCon.dispose();
    super.dispose();
  }

  final partyName = TextEditingController();
  final chairCon = TextEditingController();
  final finCon = TextEditingController();
  final raoCon = TextEditingController();
  final secCon = TextEditingController();
  final supCon = TextEditingController();
  bool isPressed = false;
  File? pImageFile;
  File? cImageFile;
  File? fImageFile;
  File? rImageFile;
  File? secImageFile;
  File? supImageFile;
  String col = 'green';
  String? imageName = "";
  String? lastThree = "";
  void _pickedImage(File image) {
    pImageFile = image;
    imageName = pImageFile!.toString();
    int index=imageName!.lastIndexOf('.')+1;
    lastThree = imageName!.substring(index,imageName!.length);
  }
  void _pickedImage2(File image) {
    cImageFile = image;
  }
  void _pickedImageF(File image) {
    fImageFile = image;
  }
  void _pickedImageR(File image) {
    rImageFile = image;
  }
  void _pickedImageSec(File image) {
    secImageFile = image;
  }
  void _pickedImageSup(File image) {
    supImageFile = image;
  }

  //String userId = FirebaseAuth.instance.currentUser!.uid;
  String userId = "Cebo Ryza";
  bool done = false;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String getRandomString2(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext) => HomePage()));
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
                UserImage(_pickedImage,false),
                SizedBox(
                  width: 10,
                ),
                inputText('party_name', 'Name of party', partyName.text, 150,
                    partyName),
              ],
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
                        content: Text('please wait...',style: TextStyle(color: Colors.indigo),),
                        actions: [
                          //_pickImage();
                          Center(child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.tealAccent,
                            size: 80,
                          ),),
                        ],
                      );
                    }
                );
                //here
                //Start*********************
                 final ref = FirebaseStorage.instance
                     .ref()
                     .child('images')
                     .child(partyName.text + getRandomString(5) + '.$lastThree');
                 await ref
                     .putFile(pImageFile!)
                    .whenComplete(() => print('Uploading Image Done'));
                final url1 = await ref.getDownloadURL();
                FirebaseFirestore.instance
                   .collection('images')
                  .doc('${partyName.text}')
                    .set({
                   'image_url1': url1,
                  'pname': partyName.text.toUpperCase(),
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: Column(
                          children: [
                            Text('Done',style: TextStyle(color: Colors.indigo),),
                          ],
                        ),
                        actions: [
                          //_pickImage();
                          MaterialButton(
                            child: Text('Ok'),
                            onPressed: (){
                              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>HomePage()));
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    }
                );
              },
            ),
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
