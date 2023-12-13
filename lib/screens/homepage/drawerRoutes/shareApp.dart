

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../main.dart';

class ShareApp extends StatefulWidget {
  const ShareApp({Key? key}) : super(key: key);

  @override
  State<ShareApp> createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {


  
  final amountController = TextEditingController();
  final passwordController = TextEditingController();

  @override
void initState() {
super.initState();
}

// @override
// void dispose() {
// super.dispose();
// _controller.dispose();
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height:344,
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: constants.appMainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)
                  )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border:
                            Border.all(color: Colors.white)),
                        child: Container(
                            child: Transform.scale(
                                scale: 0.5,
                                child: IconButton(
                  
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: Text(
                      "Share the app",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        
            SizedBox(height: 30),
                    Center(
                      child: Container(
                          // color: Colors.red,
                          width: 350,
                          height: 204,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/referAndEarn.png"),
                            fit: BoxFit.cover)
                            ,
                          ),
                        ),
                    ),
                  ],
                )
              ),
        
              SizedBox(height: 20,),
        
              Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Referral Code", style: TextStyle(fontSize: 12,color: Colors.black54),),
                          SizedBox(height: 5,),
        
                          DottedBorder(
                            padding: EdgeInsets.zero,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8),
                          dashPattern: [10, 10],
                          color: Color(0XFF286FFF),
                          strokeWidth: 2,
                          child: 
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(0XFFEAF1FF),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    // color: Colors.red,
                                    // height: 72,
                                    width: MediaQuery.of(context).size.width*0.6,
                                    child: Text("ABC1234",
                                     style: TextStyle(fontSize: 14,color: Colors.black54),),
                                  ),
                                ),
        
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("Tap to copy",
                                         style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: constants.appMainColor),),
                                )
                              ]
                            ),
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
        
                  SizedBox(height: 20,),
        
        
                  Text("OR",
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
        
        
                  SizedBox(height: 20,),
        
                  InkWell(
                            onTap: (){
                              
                              Navigator.pop(context);
                              
                
                              //will save this parameter to state management later
                            },
                            child: Container(
                              width: 240,
                              height: 48,
                              decoration: BoxDecoration(
                                color: constants.appMainColor,
                                borderRadius: BorderRadius.circular(200)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Share",
                                      style: TextStyle(
                                        color:Colors.white,
                                        fontSize: 14),),
        
                                    SizedBox(width: 5,),
        
                                    SvgPicture.asset("assets/svg/share.svg", color: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
                          ),
        
                          SizedBox(height: 30,),
        
                          SizedBox(height: 20,),
        
              Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("How it Works", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),),
                          SizedBox(height: 10,),
        
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1
                                  )
                                ),
                                child: Center(
                                  child: Text("1", 
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black),
                                  )
                                )
                              ),
        
                              SizedBox(width: 5,),
                              Text("Copy referral code or use the share button to invite", style: TextStyle(fontSize: 12,color: Colors.black),),
                            ],
                          ),
                          SizedBox(height: 10,),
        
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1
                                  )
                                ),
                                child: Center(
                                  child: Text("2", 
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black),
                                  )
                                )
                              ),
        
                              SizedBox(width: 5,),
                              Text("Friends accept invite and complete registeration", style: TextStyle(fontSize: 12,color: Colors.black),),
                            ],
                          ),
                          SizedBox(height: 10,),
        
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1
                                  )
                                ),
                                child: Center(
                                  child: Text("3", 
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black),
                                  )
                                )
                              ),
        
                              SizedBox(width: 5,),
                              Text("Collect N500 earning directly to your wallet!", style: TextStyle(fontSize: 12,color: Colors.black),),
                            ],
                          ),
                          SizedBox(height: 5,),
        
                          
                        ],
                      ),
                    ),
                  ),
              
            ],
          ),
        )
      )
    );
  }
}
