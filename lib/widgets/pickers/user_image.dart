import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserImage extends StatefulWidget {
  UserImage(this.imagePickFn, this.change);
  bool change;
  final void Function(File pickedImage) imagePickFn;
  @override
  State<UserImage> createState() => _UserImageState(change: change);
}

class _UserImageState extends State<UserImage> {
  _UserImageState({required this.change});
  var myPic = ImageSource.camera;
  var pickedPic;
  final bool change;
  void _pickImage(ImageSource myPic) async {
    //ImagePicker.pickImage(source: ImageSource.gallery);
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: myPic, imageQuality: 100, maxWidth: 150); //getImage(...);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      pickedPic = pickedImageFile;
    });
    widget.imagePickFn(pickedPic);
  }
  void _checkPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
      Permission.photos
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    PermissionStatus? statusPhotos = statues[Permission.photos];
    bool isGranted = statusCamera == PermissionStatus.granted &&
        statusStorage == PermissionStatus.granted &&
        statusPhotos == PermissionStatus.granted;
    if (isGranted) {
      //openCameraGallery();
      //_openDialog(context);
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ||
            statusPhotos == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {
      //_showSettingsDialog(context);
      print("Fuck you !!!!!!!!!!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pickedPic != null
            ? GestureDetector(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: pickedPic != null ? FileImage(pickedPic) : null,//This is different
                backgroundColor: Colors.grey,
              ),
              Positioned(
                bottom: 1,
                left: 75,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.tealAccent],
                    ),
                  ),
                  child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _checkPermission(context);
                        _showPicker(context);
                      }),
                ),
              )
            ],
            clipBehavior: Clip.none,
          ),
          onTap: () {
            _checkPermission(context);
            _showPicker(context);
          },
        )
            : change
            ? GestureDetector(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/green_user.gif'),
                // backgroundColor: Colors.red,
              ),
              Positioned(
                bottom: 1,
                left: 75,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.tealAccent],
                    ),
                  ),
                  child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _checkPermission(context);
                        _showPicker(context);
                      }),
                ),
              )
            ],
            clipBehavior: Clip.none,
          ),
          onTap: () {
            _checkPermission(context);
            _showPicker(context);
          },
        )
            : GestureDetector(
          child: Container(
            width: 100,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.teal,
              gradient: LinearGradient(
                colors: [Colors.black, Colors.red],
              ),
            ),
            // height: 62,
            child: Wrap(
              //mainAxisAlignment: MainAxisAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                Icon(Icons.image, color: Colors.white),
                Text(
                  'image',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          onTap: () {
            _checkPermission(context);
            _showPicker(context);
          },
        ),
      ],
    );
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Gallery'),
                      onTap: () {
                        setState(() {
                          myPic = ImageSource.gallery;
                        });
                        _pickImage(myPic);
                        Navigator.pop(context);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      setState(() {
                        myPic = ImageSource.gallery;
                      });
                      _pickImage(myPic);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  }
