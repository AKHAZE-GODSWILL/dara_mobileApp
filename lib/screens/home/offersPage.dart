import 'dart:io';

import 'package:dara_app/main.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget{
  OffersPage({Key? key}): super(key: key);

  @override
  State<OffersPage> createState() => _OffersPage();
}

class _OffersPage extends State<OffersPage>{
  String imgPath = "";
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: false,
        titleSpacing: 0,
        title: Transform(
          transform: Matrix4.translationValues(-40, 0, 0),
          child: Text("Offers", 
            style: TextStyle(
              fontSize: 18,
              fontWeight:FontWeight.bold,
              color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey
                  )
                ),
                child: Icon(Icons.more_horiz_outlined, color: Colors.black,),
              ),
          
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: ListView.separated(
          // physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical:5),
              child: Container(
                padding: EdgeInsets.only(left:10,right: 10 ),
                // color: Colors.yellow,
                height: 88,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (imgPath.isEmpty)? Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0XFFF3F4F6),
                        shape: BoxShape.circle
                      ),
                      child: Icon(Icons.person_rounded, 
                        size: 50,
                        color: Colors.grey,),
                                        )
                      :Container(
                        width: 48,
                        height:48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        child: ClipOval(
                          child: Image.file(
                            File(imgPath),
                            fit: BoxFit.cover
                          ),
                        )
                      ),
            
                      SizedBox(width: 10,),
            
                    Container(
                      // color: Colors.blue,
                      width: 280,
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Daniel Smith sent request to hire your services for a project", 
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black),
                          ),
                          SizedBox(height: 5,),
                          Text("8h",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey
                                )
                              ),
                          SizedBox(height: 5,),
                          Container(
                            width: 288,
                            height: 32,
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    /////////////////// Push to the next page after user has selected a tier
                      
                                    //will save this parameter to state management later
                                  },
                                  child: Container(
                                    width: 88,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color:  constants.appMainColor,
                                      borderRadius: BorderRadius.circular(200)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                          color:Colors.white,
                                          fontSize: 14),),
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: (){
                                    /////////////////// Push to the next page after user has selected a tier
                      
                                    //will save this parameter to state management later
                                  },
                                  child: Container(
                                    width: 88,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: constants.appMainColor,
                                        width: 1
                                      ),
                                      borderRadius: BorderRadius.circular(200)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Accept",
                                        style: TextStyle(
                                          color: constants.appMainColor,
                                          fontSize: 14),),
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: (){
                                    /////////////////// Push to the next page after user has selected a tier
                      
                                    //will save this parameter to state management later
                                  },
                                  child: Container(
                                    width: 88,
                                    height: 32,
                                    child: Center(
                                      child: Text(
                                        "Decline",
                                        style: TextStyle(
                                          color:Colors.red,
                                          fontSize: 14),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      ),
    );
  }

}