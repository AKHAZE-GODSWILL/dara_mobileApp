import 'package:flutter/material.dart';

class Onboard2 extends StatefulWidget {
 const Onboard2({Key? key}): super(key: key);

 @override
 State<Onboard2> createState() => _Onboard2State();
}

class _Onboard2State extends State<Onboard2>{

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
      
            Container(
              // color: Colors.red,
              width: MediaQuery.of(context).size.width*0.85,
              height: MediaQuery.of(context).size.width*0.85,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/onboardImg2.png"),
                fit: BoxFit.cover)
                ,
              ),
            ),

            SizedBox(height: 20,),

            Padding(
               padding: const EdgeInsets.symmetric(horizontal:10),
              child: Text("Discover Trusted Services",
               style: TextStyle(fontSize: 20),
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10),
              child: Text("Experience a new way of finding reliable and trustworthy clients. Dara also connect clients with verified experts who deliver top-notch work.",
               style: TextStyle(fontSize: 12),
               textAlign: TextAlign.center,
              ),
            )
          ],
      
        ),
      )
    );
  }


}

