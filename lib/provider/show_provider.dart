import 'package:flutter/material.dart';
class showProvider with ChangeNotifier{
  bool show = false;
  bool get showS => show;
  void showIt(){
    show = true;
    notifyListeners();
  }
  void hideIt(){
    show = false;
    notifyListeners();
  }
}