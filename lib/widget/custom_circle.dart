import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';




circularCustom(context)async{
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return WillPopScope (
          onWillPop: () async {
            Navigator.pop(context);
            return true;
          },
          child: Dialog(
            elevation: 0,
            child:  CupertinoActivityIndicator(
              radius: 30,
            ),
            backgroundColor: Colors.transparent,
          ),
        );
      });
}