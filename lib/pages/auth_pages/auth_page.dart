//import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../widgets/auth_widget/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String password, String username,String occupation,File? image,bool isLogin,BuildContext ctx) async {
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

        final ref = FirebaseStorage.instance.ref().child('user_image').child(authResult.user!.uid + '.jpg');
        await ref.putFile(image!).whenComplete(() => print('Uploading Image Done'));
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users5').doc(authResult.user?.uid).set({
          'username': username,
          'occupation': occupation,
          'email': email,
          'image_url': url,
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
    return Container(
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.centerRight,
      //         colors: [Colors.orange,Colors.red, Colors.green,])),
      color: Colors.white,
      child: Scaffold(
        //backgroundColor: Theme.of(context).primaryColor,
         backgroundColor: Colors.teal,
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.teal, Colors.teal],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                //border: Border.all(color: Colors.white),
                // borderRadius: BorderRadius.all(
                //   Radius.circular(40),
                // ),
              ),
              child: AuthForm(_submitAuthForm,_isLoading)),
        ),
      ),
    );
  }
}
