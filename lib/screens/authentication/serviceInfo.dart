import 'dart:io';

import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/registration.dart';
import 'package:dara_app/screens/home/bottomNavBar.dart';
import 'package:dara_app/screens/home/homePage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Service_Info extends StatefulWidget{
  Service_Info({Key? key}): super(key: key);

  @override
  State<Service_Info> createState() => _Service_Info();
}

class _Service_Info extends State<Service_Info>{

  String updatedImage = "";
  String imgPath = "";
  String imgExt = "";

  File? readyUploadImage;
  bool hasImg = false;

  final bioController = TextEditingController();
  final experienceController = TextEditingController();
  String? dropdownvalueServices;
  String? dropdownvalueSkills;
  
  var services = [
    "Cleaner",
    "Bus driver",
    "Barbing",
  ];

  var skill = [
    "drumming",
    "dancing",
    "playing football"
  ];
  final textNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool isObscured = false;

  @override
  void initState() {
    // TODO: implement initState

    isObscured = true;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    bioController.dispose();
    experienceController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Information", 
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: 20,),
              Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10),
                        child: CircularPercentIndicator(
                                      radius: 50.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      lineWidth: 7.0,
                                      percent: 0.6,
                                      center: new Text(
                                        "60%",
                                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      backgroundColor: Color(0XFFF3F4F6),
                                      progressColor: constants.appMainColor,
                                    ),
                      ),
                      Container(
                        // color: Colors.red,
                        height: 92,
                        width: 234,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [  
                              Text("You're Almost Done",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                              ),
                                    
                                    
                              SizedBox(height: 10,),
                                    
                              Text("Maximize your experience as a service provide with Dara by connecting with clients. Complete these steps to make the most out of the platform",
                              style: TextStyle(
                                fontSize: 12,),
                              ),
                                    
                              SizedBox(height: 10,),
                                    
                              
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              

                SizedBox(height: 20,),

                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: (imgPath.isEmpty)? Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Color(0XFFF3F4F6),
                          shape: BoxShape.circle
                        ),
                        child: Icon(Icons.person_rounded, 
                          size: 50,
                          color: Colors.grey,),
                                          )
                        :Container(
                          width: 64,
                          height:64,
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
                      ),

                ////////////////////////////// The add/ change Image panel is here and it involves using image picker
                SizedBox(height: 20,),

                // Add/Change Image
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add/Change Image", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Select file",
                              style: TextStyle(
                                fontSize: 14
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                /////////// Call the pick image method and change the image to replace the icon
                                getImageGallery();
                                print(">>>>>>>>>>>> Printing the get image place");
                              },
                              child: Text("Upload Image",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: constants.appMainColor
                                ),
                              ),
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ),

                SizedBox(height: 20,),
                // Bio
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bio", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,),
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                        child: TextFormField(
                          // focusNode: textNode,
                          onChanged: (value){
                        setState(() {
                          
                        });
                      },  
                          keyboardType: TextInputType.multiline,
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: null,
                          expands: true,
                          minLines: null,
                          controller: bioController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Add a few words about yourself",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),
              
              // Services
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Services", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width*0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black38,
                            ),
                            hint: Text(
                              'Choose your kind of serices',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            items: services
                                .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style:  TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: dropdownvalueServices,
                            onChanged: (value) {
                              setState(() {
                                dropdownvalueServices = value as String;
                              });
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),
              
              //Skills
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Skills", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width*0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black38,
                            ),
                            hint: Text(
                              'Select Your skills',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            items: skill
                                .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style:  TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: dropdownvalueSkills,
                            onChanged: (value) {
                              setState(() {
                                dropdownvalueSkills = value as String;
                              });
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),

              //Experience
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Experience", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                        child: TextFormField(
                          // focusNode: textNode,
                          onChanged: (value){
                        setState(() {
                          
                        });
                      },
                          keyboardType: TextInputType.emailAddress,
                          controller: experienceController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Years of experience",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                    ],
                  ),
                ),
              
              SizedBox(height: 30,),
              
                        InkWell(
                          onTap: (){
                            /////////////////// Push to the next page after user has selected a tier
                            
                            if(
                              bioController!.text.isNotEmpty
                              && dropdownvalueServices != null
                              && dropdownvalueSkills != null 
                              && experienceController.text.isNotEmpty){
                              ///// Navigation.push to the OTP screen
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BottomNavBar())
                              );
                            }

                            
              
                            //will save this parameter to state management later
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.85,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (
                                bioController!.text.isEmpty 
                                || dropdownvalueServices == null
                                || dropdownvalueSkills == null
                                || experienceController.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: (bioController!.text.isEmpty 
                                || dropdownvalueServices == null
                                || dropdownvalueSkills == null
                                || experienceController.text.isEmpty)? Color(0XFF6B7280):Colors.white,
                                  fontSize: 14),),
                            ),
                          ),
                        ),

                        SizedBox(height: 30,)
              
              // Padding(padding: )
            ],
          ),
        ),
      ),
    );
  }

  getImageGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((selectedImage) {
      if (selectedImage == null) return;

      readyUploadImage = File(selectedImage.path);
      print(readyUploadImage!.path);
      setState(() {
        imgPath = readyUploadImage!.path;
        imgExt = imgPath.split(".").last;
        hasImg = true;
      });

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             ProfilePic(imgPath: imgPath, updateUserImage: updateLocalProfilePic,))); //onSendImage
    });
  }
}