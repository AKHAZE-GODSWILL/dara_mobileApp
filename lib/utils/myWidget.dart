import 'package:fluttertoast/fluttertoast.dart';

class Mywidget{

  void displayToast({ required msg}){
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.TOP);
  }
}