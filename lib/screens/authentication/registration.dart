import 'package:dara_app/main.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
 const Registration({Key? key}): super(key: key);

 @override
 State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>{

  String selectedTier ="";


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

     
          ],
      
        ),
      )
    );
  }


}

