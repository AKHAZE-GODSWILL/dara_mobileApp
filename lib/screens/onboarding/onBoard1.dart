import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboard1 extends StatefulWidget {
 const Onboard1({Key? key}): super(key: key);

 @override
 State<Onboard1> createState() => _Onboard1State();
}

class _Onboard1State extends State<Onboard1>{

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
                  image: AssetImage("assets/onboardImg1.png"),
                fit: BoxFit.cover)
                ,
              ),
            ),

            SizedBox(height: 20,),

            Padding(
               padding: const EdgeInsets.symmetric(horizontal:10),
              child: Text("Welcome to Dara!",
               style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10),
              child: Text("Connecting Trusted and Reliable professionals with clients for household and professional needs",
               style: GoogleFonts.inter(fontSize: 12),
               textAlign: TextAlign.center,
              ),
            )
          ],
      
        ),
      )
    );
  }


}

