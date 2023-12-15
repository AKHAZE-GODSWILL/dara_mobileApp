import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/screens/authentication/login.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/chatHistory.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/daraSupport.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/settingsPage.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/shareApp.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/wallet.dart';
import 'package:dara_app/screens/homepage/viewOffers.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ph/**/osphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/profile.png"),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                ),

                Row(
                  children: [
                    Text(
                      "Michael Traore",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
                    ),

                    SvgPicture.asset("assets/svg/verified-badge.svg")
                  ],
                ),

                Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/ranking.svg"),
                  Text(" Rising Star", style: GoogleFonts.inter(
                      color: Color(0xFFf97315),
                      fontWeight: FontWeight.bold,
                      fontSize: 10
                      ),)
                ],
              ),
              height: 24,
              width: 85,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFf97315)),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            SizedBox(height: 5,),

            InkWell(
              onTap: (){

                if(provider.userType == "serviceProvider"){
                  provider.setUserType(userTier: "client");
                }
                else{
                  provider.setUserType(userTier: "serviceProvider");
                }

                Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => Login()),
                                (route) => false,
                              );
              },
              child: Text(
                       (provider.userType == "serviceProvider")? "Use Dara as client":"Use Dara as a Service Provider",
                        style: GoogleFonts.inter(
                          color: constants.appMainColor,
                          fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
              ],
            )
          ),
          ListTile(
            leading: SvgPicture.asset("assets/svg/wallet.svg"),
            title: Text('Wallet (Available Soon)', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)
              ),
            onTap: () {
              Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return WalletPage();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        )
                      );
            },
          ),
          ListTile(
            leading: SvgPicture.asset("assets/svg/chat-history.svg"),
            title: Text('Chat History', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              
              // Navigator.pop(context); // Close the drawer
              Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ChatHistory();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        )
                      );
            },
          ),
          ListTile(
            leading: SvgPicture.asset("assets/svg/settings.svg"),
            title: Text('Settings', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return Settings();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        )
                      );
            },
          ),

          ListTile(
            leading: SvgPicture.asset("assets/svg/support.svg"),
            title: Text('Support', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              // Add your settings page navigation logic here
              
              Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return DaraSupport();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        )
                      );
            },
          ),

          Divider(),

          ListTile(
            leading: SvgPicture.asset("assets/svg/share.svg"),
            title: Text('Share the App', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ShareApp();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        )
                      );
            },
          ),

          ListTile(
            leading: SvgPicture.asset("assets/svg/about-us.svg"),
            title: Text('About Us', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              // Add your settings page navigation logic here
              Navigator.pop(context); // Close the drawer
            },
          ),

          ListTile(
            leading:  SvgPicture.asset("assets/svg/logout.svg"),
            title: Text('Log Out', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => Login()),
                  (route) => false,
                );
            },
          ),
        ],


      ),
    ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 19),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Offers",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      print("The Open drawer button clicked");
                      // Scaffold.of(context).openDrawer();
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.black12)),
                          child: Container(
                            child: Transform.scale(
                                scale: 0.5,
                                child: SvgPicture.asset("assets/svg/more.svg")))
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Container(
                            height: 15,
                            width: 23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Center(
                                child: Text(
                              "9+",
                              style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
                            )),
                          ),
                        ),
                      ],
                    ), 
                    
                    // Container(
                    //     height: 42,
                    //     width: 42,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(100),
                    //         border: Border.all(color: Colors.black12)),
                    //     child: 
                        
                    //     Container(
                    //         child: Transform.scale(
                    //             scale: 0.5,
                    //             child: SvgPicture.asset("assets/svg/more.svg")))),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index){

              return (provider.userType == "serviceProvider")? serviceProviderOfferWidget(index: index): clientOfferWidget(index: index);
            })
          ],
        ),
      ),
    );
  }

  Widget serviceProviderOfferWidget({required index}){
    return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundImage:
                                    AssetImage("assets/profile1.png"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 32),
                                    child: Container(
                                      child: Text(""),
                                      height: 12,
                                      width: 12,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: Colors.white, width: 2),
                                          color: Colors.green
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.75,
                                  child: RichText(text: TextSpan(children: [
                                    TextSpan(
                                      text:  "Daniel ",
                                      style: TextStyle(fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    TextSpan(
                                      text:  "sent a request to hire your services for a project",
                                      style: TextStyle(fontSize: 12, color: Colors.black),
                                    )])),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "6h",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),



                          ],
                        ),
                      ),

                       Row(children: [
                        SizedBox(width: MediaQuery.of(context).size.width*0.125,),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return ViewOffers();
                              },
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            )
                          );
                          },
                          child: Container(
                            width: 88,
                            height: 32,
                            decoration: BoxDecoration(
                                color: constants.appMainColor,
                                borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: Text(
                                "View Details",
                                style: TextStyle(
                                    color:  Colors.white,
                                    fontSize: 14),),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InkWell(
                            onTap: (){
                              CustomSuccessDialog();
                            },
                            child: Container(
                              width: 88,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: constants.appMainColor, width: 2),
                                  borderRadius: BorderRadius.circular(200)
                              ),
                              child: Center(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      color:   constants.appMainColor,
                                      fontSize: 14),),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InkWell(
                            onTap: (){
                              CustomAcknowledgedDialog();
                            },
                            child: Container(
                              width: 88,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200)
                              ),
                              child: Center(
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                      color:   Colors.red,
                                      fontSize: 14),),
                              ),
                            ),
                          ),
                        ),
                      ],)

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Divider(),
                )
              ],
            );
  }

  Widget clientOfferWidget({required index}){
    return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundImage:
                                    AssetImage("assets/profile1.png"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 32),
                                    child: Container(
                                      child: Text(""),
                                      height: 12,
                                      width: 12,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: Colors.white, width: 2),
                                          color: Colors.green
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.75,
                                  child: (index%2 == 0)? RichText(text: TextSpan(children: [
                                    
                                    TextSpan(
                                      text:  "You sent a request to hire ",
                                      style: TextStyle(fontSize: 12, color: Colors.black),
                                    ),

                                    TextSpan(
                                      text:  "Grace Williams ",
                                      style: TextStyle(fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),

                                    TextSpan(
                                      text:  "services for a project",
                                      style: TextStyle(fontSize: 12, color: Colors.black),
                                    ),
                                    
                                    ]))
                                    
                                    :RichText(text: TextSpan(children: [
                                    TextSpan(
                                      text:  "Daniel Smith ",
                                      style: TextStyle(fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    TextSpan(
                                      text:  "sent a request to confirm that your project was completed",
                                      style: TextStyle(fontSize: 12, color: Colors.black),
                                    )])) ,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "6h",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),



                          ],
                        ),
                      ),

                      Row(children: [
                        SizedBox(width: MediaQuery.of(context).size.width*0.125,),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return ViewOffers();
                              },
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            )
                          );
                          },
                          child: Container(
                            width: 139,
                            height: 32,
                            decoration: BoxDecoration(
                                color: constants.appMainColor,
                                borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: Text(
                                "View Details",
                                style: TextStyle(
                                    color:  Colors.white,
                                    fontSize: 14),),
                            ),
                          ),
                        ),
                        (index%2 == 0)? Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InkWell(
                            onTap: (){

                            },
                            child: Container(
                              width: 139,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: constants.appMainColor, width: 2),
                                  borderRadius: BorderRadius.circular(200)
                              ),
                              child: Center(
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                      color:   constants.appMainColor,
                                      fontSize: 14),),
                              ),
                            ),
                          ),
                        ):Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InkWell(
                            onTap: (){

                            },
                            child: Container(
                              width: 139,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200)
                              ),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color:   Colors.red,
                                      fontSize: 14),),
                              ),
                            ),
                          ),
                        ),
                      ],)

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Divider(),
                )
              ],
            );
  }

  ////////////////// Success Dialog
  CustomSuccessDialog(){
    return showDialog(
      barrierColor: Color(0XFF121212).withOpacity(0.7),
      context: context,
      builder: (context){
        return StatefulBuilder(builder: (context, setState){
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width*0.9,
                  // height: 338,
                  // width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 105,
                        width: 105,
                        decoration: BoxDecoration(
                          color: Color(0XFF22C55E),
                          shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check, 
                            color: Colors.white,
                            size: 80,
                            ),
                        ),
                      ),
                      SizedBox(height: 20,),

                      Text("Confirmed",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center,
                          ),

                      SizedBox(height: 20,),
                      
                      Text("Project hire from Daniel Smith Accepted",
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Color(0XFF374151),
                            decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center,
                          ),

                      SizedBox(height: 20,),
                      
                      Container(
                        child: GestureDetector(

                          onTap: (){
                            // Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.85,
                            height: 50,
                            decoration: BoxDecoration(
                              // color: (_textEditingController!.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                              color: constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: Text(
                                "Done",
                                style: GoogleFonts.inter(
                                  // color: (_textEditingController!.text.isEmpty)? Color(0XFF6B7280):Colors.white,
                                  color: Colors.white,
                                  fontSize: 14,
                                  decoration: TextDecoration.none),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      }
    );
  }


  /////////////////// Acknowledged dialogue
  CustomAcknowledgedDialog(){
    return showDialog(
      barrierColor: Color(0XFF121212).withOpacity(0.7),
      context: context,
      builder: (context){
        return StatefulBuilder(builder: (context, setState){
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width*0.9,
                  // height: 338,
                  // width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 105,
                        width: 105,
                        child: Center(
                          child: SvgPicture.asset("assets/svg/acknowledged.svg")
                        ),
                      ),

                      SizedBox(height: 20,),

                      Text("Acknowledged",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center,
                          ),

                      SizedBox(height: 20,),
                      
                      Text("Project hire from Daniel Smith declined",
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Color(0XFF374151),
                            decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center,
                          ),
                        SizedBox(height: 20,),
                      
                      Container(
                        child: GestureDetector(

                          onTap: (){
                            // Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.85,
                            height: 50,
                            decoration: BoxDecoration(
                              // color: (_textEditingController!.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                              color: constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: Text(
                                "Done",
                                style: GoogleFonts.inter(
                                  // color: (_textEditingController!.text.isEmpty)? Color(0XFF6B7280):Colors.white,
                                  color: Colors.white,
                                  fontSize: 14,
                                  decoration: TextDecoration.none),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      }
    );
  }
}