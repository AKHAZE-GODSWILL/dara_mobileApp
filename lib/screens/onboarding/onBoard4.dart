import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboard4 extends StatefulWidget {
 const Onboard4({Key? key}): super(key: key);

 @override
 State<Onboard4> createState() => _Onboard1State();
}

class _Onboard1State extends State<Onboard4>{

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
                  image: AssetImage("assets/onboardImg4.png"),
                fit: BoxFit.cover)
                ,
              ),
            ),

            SizedBox(height: 20,),

            Padding(
               padding: const EdgeInsets.symmetric(horizontal:10),
              child: Text("Engage and connect",
               style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10),
              child: Text("Connect with your ideal client in search of Top-Notch services - Find your perfect match!",
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
