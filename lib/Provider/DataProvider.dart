



import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {

  int pageIndex = 0;

  setValue(value){
    pageIndex = value;
    notifyListeners();
  }
}