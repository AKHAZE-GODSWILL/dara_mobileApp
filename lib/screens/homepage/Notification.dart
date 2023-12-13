import 'package:dara_app/Provider/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: false,
        titleSpacing: 0,
        title: Transform(
          transform: Matrix4.translationValues(-55, 0, 0),
          child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border:
                          Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:12.0),
                  child: Text(
                    "Notifications",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                // Spacer(),
              ],
            ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: (provider.userType == "serviceProvider")? ListView(
        children: [
          confirmedCompletion(context: context),
          reviewedProjectCompletion(context: context),
          subScribedToNetwork(context: context),
          likedPost(context: context),
          commentedOnPost(context: context)

        ],
      )
      :ListView(
        children: [
          acceptedProjectHire(context: context),
          repliedProfileReview(context: context),
          projectCompletion(context: context)

        ],
      )
      
      // ListView.builder(
      //   itemCount: 5,
      //   itemBuilder: (context,index){
      //   return Column(
      //         children: [
      //           Column(
      //             children: [
      //               Padding(
      //                 padding: EdgeInsets.only(left: 12.0, right: 12),
      //                 child: Column(
      //                   children: [
      //                     Padding(
      //                       padding: EdgeInsets.only(top: 8.0, bottom: 0),
      //                       child: Row(
      //                         children: [
      //                           Padding(
      //                             padding: EdgeInsets.only(right: 8.0),
      //                             child: Stack(
      //                               children: [
      //                                 CircleAvatar(
      //                                   radius: 25,
      //                                   backgroundImage:
      //                                   AssetImage("assets/profile1.png"),
      //                                 ),
      //                                 Padding(
      //                                   padding: EdgeInsets.only(left: 38),
      //                                   child: Container(
      //                                     child: Text(""),
      //                                     height: 12,
      //                                     width: 12,
      //                                     decoration: BoxDecoration(
      //                                         borderRadius: BorderRadius.circular(100),
      //                                         border: Border.all(color: Colors.white, width: 2),
      //                                         color: Colors.green
      //                                     ),
      //                                   ),
      //                                 )
      //                               ],
      //                             ),
      //                           ),
      //                           Column(
      //                             mainAxisAlignment: MainAxisAlignment.start,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   Container(
      //                                     width: MediaQuery.of(context).size.width*0.62,
      //                                     child: RichText(text: TextSpan(children: [
      //                                       TextSpan(
      //                                         text: (provider.userType == "client")?  "Daniel Smith ": "Daniel ",
      //                                         style: GoogleFonts.inter(fontSize: 12,
      //                                             fontWeight: FontWeight.bold,
      //                                             color: Colors.black),
      //                                       ),
      //                                       TextSpan(
      //                                         text:  "gave you review on your successful project completion",
      //                                         style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
      //                                       )])),
      //                                   ),
      //                                   SizedBox(width:MediaQuery.of(context).size.width*0.08),
      //                                   SvgPicture.asset("assets/svg/more.svg")
      //                                 ],
      //                               ),
                                    
      //                               Padding(
      //                                 padding: const EdgeInsets.all(2.0),
      //                                 child: Text(
      //                                   "2m",
      //                                   style: GoogleFonts.inter(
      //                                       fontSize: 12, color: Colors.black),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),



      //                         ],
      //                       ),
      //                     ),


      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 8.0, right: 8),
      //                 child: Divider(),
      //               )
      //             ],
      //           ),
      //         ],
      //       );
      // })
    );
  }

  Widget acceptedProjectHire({required context}){
      DataProvider provider = Provider.of<DataProvider>(context, listen: true);
      return Column(
              children: [
                Column(
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
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
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
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.62,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text: (provider.userType == "client")?  "Daniel Smith ": "Daniel ",
                                              style: GoogleFonts.inter(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text:  "just accepted your project Hire",
                                              style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: GoogleFonts.inter(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),
              ],
            );
  }

  Widget repliedProfileReview({required context}){
      DataProvider provider = Provider.of<DataProvider>(context, listen: true);
      return Column(
              children: [
                Column(
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
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
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
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.62,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text: (provider.userType == "client")?  "Daniel Smith ": "Daniel ",
                                              style: GoogleFonts.inter(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text:  "replied your review on his profile",
                                              style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: GoogleFonts.inter(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),
              ],
            );
  }

  Widget projectCompletion({required context}){
      DataProvider provider = Provider.of<DataProvider>(context, listen: true);
      return Column(
              children: [
                Column(
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
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
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
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.62,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text: (provider.userType == "client")?  "Daniel Smith ": "Daniel ",
                                              style: GoogleFonts.inter(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text:  "just completed your project on service laundry",
                                              style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: GoogleFonts.inter(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),
              ],
            );
  }

  Widget confirmedCompletion({required context}){
      DataProvider provider = Provider.of<DataProvider>(context, listen: true);
      return Column(
              children: [
                Column(
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
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
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
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.62,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text: (provider.userType == "client")?  "Daniel Smith ": "Daniel ",
                                              style: GoogleFonts.inter(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text:  "just confirmed that you completed his fumigation project",
                                              style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: GoogleFonts.inter(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),
              ],
            );
  }


  Widget reviewedProjectCompletion({required context}){
      DataProvider provider = Provider.of<DataProvider>(context, listen: true);
      return Column(
              children: [
                Column(
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
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
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
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.62,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text: (provider.userType == "client")?  "Daniel Smith ": "Daniel ",
                                              style: GoogleFonts.inter(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text:  "gave you review on your successful project completion",
                                              style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: GoogleFonts.inter(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),
              ],
            );
  }



  Widget subScribedToNetwork({required context}){
      DataProvider provider = Provider.of<DataProvider>(context, listen: true);
      return Column(
              children: [
                Column(
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
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
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
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.62,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text: (provider.userType == "client")?  "Daniel Smith ": "Daniel ",
                                              style: GoogleFonts.inter(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text:  "subscribed to your services and become part of your network",
                                              style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: GoogleFonts.inter(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),
              ],
            );
  }



  Widget likedPost({required context}){
      DataProvider provider = Provider.of<DataProvider>(context, listen: true);
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                            padding: EdgeInsets.only(top:10,right: 8.0),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                  AssetImage("assets/profile1.png"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 38),
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
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 0),
                      child: Row(
                        children: [
                          
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.62,
                                    child: RichText(text: TextSpan(children: [
                                      TextSpan(
                                        text: (provider.userType == "client")?  "Daniel Smith ": "Daniel ",
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text:  "liked your post",
                                        style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                                      )])),
                                  ),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                  SvgPicture.asset("assets/svg/more.svg")
                                ],
                              ),

                              Container(
                                height: 64,
                                width:MediaQuery.of(context).size.width*0.68,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/accBg.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  "1d",
                                  style: GoogleFonts.inter(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                            ],
                          ),



                        ],
                      ),
                    ),


                  ],
                ),
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


  Widget commentedOnPost({required context}){
      DataProvider provider = Provider.of<DataProvider>(context, listen: true);
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                            padding: EdgeInsets.only(top: 10,right: 8.0),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                  AssetImage("assets/profile1.png"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 38),
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
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 0),
                      child: Row(
                        children: [
                          
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.62,
                                    child: RichText(text: TextSpan(children: [
                                      TextSpan(
                                        text: (provider.userType == "client")?  "Daniel Smith ": "Daniel ",
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text:  "commented your post",
                                        style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                                      )])),
                                  ),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                  SvgPicture.asset("assets/svg/more.svg")
                                ],
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width*0.68,
                                child: Text(
                                  "Your approach is the best",
                                  style: GoogleFonts.inter(
                                      fontSize: 10,
                                       color: Color(0XFF6B7280)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                height: 64,
                                width:MediaQuery.of(context).size.width*0.68,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/accBg.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  "2m",
                                  style: GoogleFonts.inter(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                            ],
                          ),



                        ],
                      ),
                    ),


                  ],
                ),
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
}
