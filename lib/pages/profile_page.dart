import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_streets/widgets/global_variables.dart';
import 'package:the_streets/widgets/pickers/post_image.dart';

import '../utils/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          var userDocument = snapshot.data!;
                          var myName = userDocument["username"];
                          var myEmail = userDocument["email"];
                          var users = snapshot.data!.data()?.length;
                          return Column(
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                myEmail,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(fontWeight: FontWeight.bold,color: Colors.lightBlue,fontSize: 15),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                myName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        }else if(snapshot.connectionState==ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }else{
                          return CircularProgressIndicator();
                        }
                      }
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // FloatingActionButton.extended(
                      //   onPressed: () {},
                      //   heroTag: 'follow',
                      //   elevation: 0,
                      //   label: const Text("Follow"),
                      //   icon: const Icon(Icons.person_add_alt_1),
                      // ),
                      // const SizedBox(width: 16.0),
                      // FloatingActionButton.extended(
                      //   onPressed: () {},
                      //   heroTag: 'Student',
                      //   elevation: 0,
                      //   backgroundColor: Colors.red,
                      //   label: Text("Student"),
                      //   icon: Icon(Icons.add),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _ProfileInfoRow()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 0),
    ProfileInfoItem("Followers", 0),
    ProfileInfoItem("Following", 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
            child: Row(
              children: [
                if (_items.indexOf(item) != 0) const VerticalDivider(),
                Expanded(child: _singleItem(context, item)),
              ],
            )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Text(
        item.title,
        style: Theme.of(context).textTheme.caption,
      )
    ],
  );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    dynamic myPic2;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.topRight,
                  colors: [Colors.black, Colors.teal]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
          child: Column(
            children: [
              SizedBox(height: 28,),
              Row(
                children: [
                  SizedBox(width: 10,),

                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.topRight,
                            colors: [Colors.teal,Colors.black,]),
                        borderRadius: BorderRadius.all(Radius.circular(30)),),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(30)),),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.logout,color: Colors.white,),
                        onPressed: (){
                          FirebaseAuth.instance.signOut();
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AuthService().handleAuthState(),));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        var userDocument = snapshot.data!;
                        var myPic = userDocument["image_url"];
                        var users = snapshot.data!.data()?.length;
                        return myPic != null ? GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: myPic!=null ? NetworkImage(myPic) : NetworkImage("https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                              ),
                            ),
                          ),
                          onTap: (){
                            myPic2 = myPic;
                            _showPicker(context,myPic,myWidth);
                          },
                        ) : CircularProgressIndicator();
                      }else if(snapshot.connectionState==ConnectionState.waiting){
                        return CircularProgressIndicator();
                      }else{
                        return CircularProgressIndicator();
                      }
                    }
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30),),
                      gradient: LinearGradient(
                        colors: [Colors.teal,Colors.black,],
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit,color: Colors.white,),
                      onPressed: (){
                        _showPicker(context,myPic2,myWidth);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
  void _showPicker(context,dynamic myPic, double myWidth) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('View image'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ViewImage(myPic: myPic,)));
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Change image'),
                    onTap: () {
                     // PostImage(_pickedImage) : SizedBox.shrink(),
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }//
}
class ViewImage extends StatelessWidget {
  const ViewImage({required this.myPic});

  final dynamic myPic;

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        title: Text("View Image"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          width: myWidth - 10,
          child: Image(
            image: myPic != null ? NetworkImage(myPic) : NetworkImage(
                "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
