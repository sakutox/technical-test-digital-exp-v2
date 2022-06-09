import 'package:flutter/cupertino.dart';

class MyProvider with ChangeNotifier{
  int number = 0;

  void myFunction(){
    number++;
    notifyListeners();
  } 
}