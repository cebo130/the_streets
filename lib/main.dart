import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_streets/pages/auth_pages/auth_page.dart';
import 'package:the_streets/pages/homepage.dart';
import 'package:the_streets/pages/profile_page.dart';
import 'package:the_streets/pages/testing_page.dart';
import 'package:the_streets/themes.dart';
import 'package:the_streets/utils/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'User Profile';

  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: AnimatedSplashScreen(
          backgroundColor: Colors.teal,
          //splash: Image.asset('assets/trans_logo.png',scale: 1,),
          splash: Image.asset('assets/streets.png'),//Text('Welcome to the Streets...',style: TextStyle(color: Colors.teal,fontSize: 18),),
           nextScreen: AuthService().handleAuthState(),
          splashTransition: SplashTransition.scaleTransition,
          duration: 2500,
          //pageTransitionType: PageTransitionType.scale,
        ),

      ),
    );
  }
}
//
// final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email'
//     ]
// );
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//
//   GoogleSignInAccount? _currentUser;
//
//   @override
//   void initState() {
//     _googleSignIn.onCurrentUserChanged.listen((account) {
//       setState(() {
//         _currentUser = account;
//       });
//     });
//     _googleSignIn.signInSilently();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Google Sign in'),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: _buildWidget(),
//       ),
//     );
//   }
//
//   Widget _buildWidget() {
//     GoogleSignInAccount? user = _currentUser;
//     if (user != null) {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(2, 12, 2, 12),
//         child: Column(
//           children: [
//             ListTile(
//               leading: GoogleUserCircleAvatar(identity: user),
//               title: Text(
//                 user.displayName ?? '', style: TextStyle(fontSize: 22),),
//               subtitle: Text(user.email, style: TextStyle(fontSize: 22)),
//             ),
//             const SizedBox(height: 20,),
//             const Text(
//               'Signed in successfully',
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 10,),
//             ElevatedButton(
//                 onPressed: signOut,
//                 child: const Text('Sign out')
//             )
//           ],
//         ),
//       );
//     } else {
//       return Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20,),
//             const Text(
//               'You are not signed in',
//               style: TextStyle(fontSize: 30),
//             ),
//             const SizedBox(height: 10,),
//             ElevatedButton(
//                 onPressed: signIn,
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('Sign in', style: TextStyle(fontSize: 30)),
//                 )
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   void signOut() {
//     _googleSignIn.disconnect();
//   }
//
//   Future<void> signIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (e) {
//       print('Error signing in *//////////////****************** $e');
//     }
//   }
//}