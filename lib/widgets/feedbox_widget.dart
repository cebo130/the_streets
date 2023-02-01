// import 'package:flutter/material.dart';
//
// Widget bottomShit() {
//   return Row(
//     children: [
//       Container(
//         width: 300,
//         padding: EdgeInsets.all(6),
//         child: TextFormField(
//           controller: repCon,
//           maxLines: 1,
//           //key: ValueKey(myKey),
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'please enter something';
//             }
//             return null;
//           },
//           keyboardType: TextInputType.emailAddress,
//           textAlign: TextAlign.center,
//           decoration: InputDecoration(
//             // fillColor: Colors.tealAccent,
//             //   filled: false,
//               focusColor: Colors.teal,
//               border: InputBorder.none,
//               focusedBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.teal),
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//               ),
//               enabledBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.teal),
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//               ),
//               isDense: true,
//               labelText: 'reply...',
//               hintText: '',
//               floatingLabelAlignment: FloatingLabelAlignment.center,
//               floatingLabelStyle: const TextStyle(fontSize: 16),
//               labelStyle: const TextStyle(fontSize: 13, color: Colors.teal)),
//           onSaved: (value) {
//             repCon.text = value!;
//           },
//         ),
//       ),
//       Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(
//               Radius.circular(30),
//             ),
//             color: Colors.teal),
//         child: IconButton(
//           icon: Icon(
//             Icons.send,
//             color: Colors.white,
//           ),
//           onPressed: () {},
//         ),
//       ),
//     ],
//   );
// }
// Widget botNav(){
//   return BottomNavigationBar(
//     items: [
//       BottomNavigationBarItem(
//         icon: Container(
//           width: 300,
//           padding: EdgeInsets.all(6),
//           child: TextFormField(
//             controller: repCon,
//             maxLines: 1,
//             //key: ValueKey(myKey),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'please enter something';
//               }
//               return null;
//             },
//             keyboardType: TextInputType.emailAddress,
//             textAlign: TextAlign.center,
//             decoration: InputDecoration(
//               // fillColor: Colors.tealAccent,
//               //   filled: false,
//                 focusColor: Colors.teal,
//                 border: InputBorder.none,
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.teal),
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.teal),
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                 ),
//                 isDense: true,
//                 labelText: 'reply...',
//                 hintText: '',
//                 floatingLabelAlignment: FloatingLabelAlignment.center,
//                 floatingLabelStyle: const TextStyle(fontSize: 16),
//                 labelStyle: const TextStyle(fontSize: 13, color: Colors.teal)),
//             onSaved: (value) {
//               repCon.text = value!;
//             },
//           ),
//         ),
//         label: "",
//       ),
//       BottomNavigationBarItem(
//         icon: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(30),),color: Colors.teal
//           ),
//           child: IconButton(
//             icon: Icon(Icons.send,color: Colors.white,),
//             onPressed: (){},
//           ),
//         ),
//         label: "",
//       ),
//      ],
//   );
//  }
// }
