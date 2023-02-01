import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_streets/pages/auth_pages/auth_page.dart';

import '../Testing/tesing.dart';
import '../pages/homepage.dart';
import '../pages/login_page.dart';
import '../pages/testing_page.dart';

class AuthService{
  //1. handle AuthSate
  handleAuthState(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return HomePage();
        }else{
          return AuthPage();
        }
      }
    );
  }
  //2. sign in with google
 // signInWithGoogle()async{
 //    //Trigger auth flow
 //   final GoogleSignInAccount? googleUser = await GoogleSignIn(
 //     scopes: <String>["email"]).signIn();
 //   //Obtain the Auth details from the request
 //   final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
 //   //create a new credential
 //   final credential = GoogleAuthProvider.credential(
 //     accessToken: googleAuth.accessToken,
 //     idToken: googleAuth.idToken,
 //   );
 //   //Once signed in, return the user credentials
 //   return await FirebaseAuth.instance.signInWithCredential(credential);
 // }
 //  //3. signOut
 //  signOut(){
 //    FirebaseAuth.instance.signOut();
 //  }
}