import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostImage extends StatefulWidget {
  PostImage(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;
  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  var myPic = ImageSource.camera;
  var pickedPic;
  void _pickImage(ImageSource myPic, double myWidth) async {
    //ImagePicker.pickImage(source: ImageSource.gallery);
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source:myPic,imageQuality: 100,maxWidth: myWidth-10);//getImage(...);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      pickedPic = pickedImageFile;
    });
    widget.imagePickFn(pickedPic);
  }


  /*Future pickImage()async{
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    /*setState(() {
      pickedPic = pickedImageFile as File;
    });*/
    return pickedImageFile;
  }*/
  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        /*CircleAvatar(
            radius: 50,
            backgroundImage: pickedPic != null ? FileImage(pickedPic) : null,
          backgroundColor: Colors.grey,
        ),*/
        SizedBox(height: 10,),
        pickedPic != null ? GestureDetector(
          child: Center(
            child:  Container(
              color: Colors.red,
              height: 150,
              width: 120,
              child: Image(
                image: FileImage(pickedPic),
                fit: BoxFit.cover,
              ),
            ),
          ),
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: Text('choose pic from',style: TextStyle(color: Colors.indigo),),
                    actions: [
                      //_pickImage();
                      MaterialButton(
                        child: Text('gallery'),
                        onPressed: (){
                          setState(() {
                            myPic = ImageSource.gallery;
                          });
                          _pickImage(myPic,myWidth);
                          Navigator.pop(context);
                        },
                      ),
                      MaterialButton(
                        child: Text('camera'),
                        onPressed: (){
                          setState(() {
                            myPic = ImageSource.camera;
                          });
                          _pickImage(myPic,myWidth);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
            );
          },
        ):
        GestureDetector(child:
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.red,
                Colors.black,
              ],
            ),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            //color: myCol, //Change here***********************//
          ),
          padding: const EdgeInsets.all(8),
          width: 62,
          height: 62,
          child: Wrap(
            //mainAxisAlignment: MainAxisAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              Icon(Icons.image,color: Colors.white),
              Text('image',style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: Text('choose pic from',style: TextStyle(color: Colors.indigo),),
                    actions: [
                      //_pickImage();
                      MaterialButton(
                        child: Text('gallery'),
                        onPressed: (){
                          setState(() {
                            myPic = ImageSource.gallery;
                          });
                          _pickImage(myPic,myWidth);
                          Navigator.pop(context);
                        },
                      ),
                      MaterialButton(
                        child: Text('camera'),
                        onPressed: (){
                          setState(() {
                            myPic = ImageSource.camera;
                          });
                          _pickImage(myPic,myWidth);
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
    );
  }
}
