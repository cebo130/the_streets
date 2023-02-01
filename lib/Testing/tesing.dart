import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String password, bool isLogin,BuildContext ctx) async {
    UserCredential authResult;
    try{
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult =
        await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        // final ref = FirebaseStorage.instance.ref().child('user_image').child(authResult.user!.uid + '.jpg');
        // await ref.putFile(image!).whenComplete(() => print('Uploading Image Done'));
        // final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('myUsers').doc(authResult.user?.uid).set({
          'email': email,
          'userId': authResult.user?.uid,
          'verified' : false,
        });
      }
    } on PlatformException catch(e){
      String? message = 'an error occured, please check your credentials bro...';
      if(e.message != null){
        message = e.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message!),backgroundColor: Theme.of(context).errorColor,));
      setState(() {
        _isLoading = false;
      });
    } catch (e){
      print(e);
      _isLoading = false;
      String err = e.toString();
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(err),backgroundColor: Theme.of(context).errorColor,));
    }
    _isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("nhgf"),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("send"),
                onPressed: ()async{
                  _submitAuthForm("cebo@gmail.com","12345678",false,context);
                  // await FirebaseFirestore.instance.collection('testing').doc().set({
                  //   'username': "cebo",
                  //   'occupation': "ryza",
                  //   'email': "cebo@gmail",
                  //   'image_url': "kjhgf",
                  //   'userId': "jhgfd",
                  //   'verified' : false,
                  // });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

