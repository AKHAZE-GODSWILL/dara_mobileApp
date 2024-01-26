import 'dart:io';
import 'package:dara_app/main.dart';
import '../homepage/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Service_Info extends StatefulWidget {
  Service_Info({Key? key}) : super(key: key);

  @override
  State<Service_Info> createState() => _Service_Info();
}

class _Service_Info extends State<Service_Info> {
  bool isLoading = false;
  bool isMaxWordReached = false;
  int maxWordCount = 20;
  int wordCount = 0;
  String updatedImage = "";
  String imgPath = "";
  String imgExt = "";

  File? readyUploadImage;
  bool hasImg = false;

  final bioController = TextEditingController();
  String? dropdownvalueServices;
  String? dropdownvalueSkills;
  String? dropdownValueExperience;

  List services = [];

  List skill = [];

  var experienceList = [
    "0-11months experience",
    "1 year experience",
    "2 years experience",
    "3 years experience",
    "4 years experience",
    "5 years experience",
    "6 years experience",
    "7 years experience",
    "8 years experience",
    "9 years experience",
    "10+ years experience",
  ];

  final textNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool isObscured = false;

  @override
  void initState() {
    // TODO: implement initState

    isObscured = true;
    getServices().then((value) {
      setState(() {
        for (var i in value) {
          services.add(i["name"]);
        }
      });
    });
    getSkills().then((value) {
      setState(() {
        for (var i in value) {
          skill.add(i["skill"]);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Service Information",
          style: GoogleFonts.inter(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: skill.isEmpty || services.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CircularPercentIndicator(
                              radius: 50.0,
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: 7.0,
                              percent: 0.6,
                              center: new Text(
                                "60%",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: Color(0XFFF3F4F6),
                              progressColor: constants.appMainColor,
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            height: 100,
                            width: 234,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "You're almost Done",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Maximize your experience as a service provide with Dara by connecting with clients. Complete these steps to make the most out of the platform",
                                  style: GoogleFonts.inter(
                                    color: Color(0XFF374151),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: (imgPath.isEmpty)
                                ? Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                        color: Color(0XFFF3F4F6),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.person_rounded,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  )
                                : Container(
                                    width: 64,
                                    height: 64,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: Image.file(File(imgPath),
                                          fit: BoxFit.cover),
                                    )),
                          ),

                          ////////////////////////////// The add/ change Image panel is here and it involves using image picker
                          SizedBox(
                            height: 20,
                          ),

                          // Add/Change Image
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add/Change Image",
                                    style: GoogleFonts.inter(
                                        fontSize: 12, color: Color(0XFF6B7280)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      height: 48,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0XFFE5E7EB))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Select file",
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: Color(0XFF6B7280))),
                                          InkWell(
                                            onTap: () {
                                              /////////// Call the pick image method and change the image to replace the icon
                                              getImageGallery();
                                            },
                                            child: Text(
                                              "Upload Image",
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color:
                                                      constants.appMainColor),
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          // Bio
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bio",
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Color(0XFF6B7280))),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0XFFE5E7EB))),
                                    child: TextFormField(
                                      // focusNode: textNode,
                                      onChanged: (value) {
                                        _detectWordCount();
                                      },
                                      keyboardType: TextInputType.multiline,
                                      textAlignVertical: TextAlignVertical.top,
                                      maxLines: null,
                                      expands: true,
                                      minLines: null,
                                      controller: bioController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s{2,}')),
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          return customInputFormatter(
                                              oldValue, newValue, maxWordCount);
                                        })
                                      ],
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide
                                              .none, // Remove the border when focused
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide
                                              .none, // Remove the border when enabled
                                        ),
                                        hintText:
                                            "Add a few words about yourself",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${wordCount}/20 words",
                                style: GoogleFonts.inter(
                                    fontSize: 12, color: Color(0XFF9CA3AF)),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          // Services
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Services",
                                    style: GoogleFonts.inter(
                                        fontSize: 12, color: Color(0XFF6B7280)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 48,
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0XFFE5E7EB))),
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
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: Color(0XFF6B7280))),
                                          items: services
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(item,
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black)),
                                                  ))
                                              .toList(),
                                          value: dropdownvalueServices,
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownvalueServices =
                                                  value as String;
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

                          SizedBox(
                            height: 20,
                          ),

                          //Skills
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Skills",
                                    style: GoogleFonts.inter(
                                        fontSize: 12, color: Color(0XFF6B7280)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 48,
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0XFFE5E7EB))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black38,
                                          ),
                                          hint: Text('Select Your skills',
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: Color(0XFF6B7280))),
                                          items: skill
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(item,
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black)),
                                                  ))
                                              .toList(),
                                          value: dropdownvalueSkills,
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownvalueSkills =
                                                  value as String;
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

                          SizedBox(
                            height: 20,
                          ),

                          //Experience
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Experience",
                                    style: GoogleFonts.inter(
                                        fontSize: 12, color: Color(0XFF6B7280)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 48,
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0XFFE5E7EB))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black38,
                                          ),
                                          hint: Text('Years of experience',
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: Color(0XFF6B7280))),
                                          items: experienceList
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(item,
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black)),
                                                  ))
                                              .toList(),
                                          value: dropdownValueExperience,
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownValueExperience =
                                                  value as String;
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
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    InkWell(
                      onTap: () {
                        if (imgPath.isNotEmpty &&
                            bioController.text.isNotEmpty &&
                            dropdownvalueServices != null &&
                            dropdownvalueSkills != null &&
                            dropdownValueExperience != null) {
                          setState(() {
                            isLoading = true;
                          });
                          // getX.write(constants.GETX_SP_REG_COMPLETED,true);
                          getX.write(constants.GETX_LOGGED_IN, true);

                          userAddressInformation(
                                  imageFile: File(imgPath),
                                  country: provider.sp_country,
                                  state: provider.sp_state,
                                  area: provider.sp_lga,
                                  specificAddress: provider.sp_address,
                                  user_id: provider.sp_user_id)
                              .then((value) {
                            if (value["status"] == true) {
                              ///////////////////////////////////////// if the request is successfull, it then makes the service info endpoint
                              userServiceInformation(
                                      imageFile: File(imgPath),
                                      bio: bioController.text.trim(),
                                      service: dropdownvalueServices,
                                      skills: dropdownvalueSkills,
                                      experience: dropdownValueExperience,
                                      user_id: provider.sp_user_id)
                                  .then((value) {
                                mywidgets.displayToast(
                                    msg:
                                        "End point worked and this is the error");
                                if (value["status"] == true) {
                                  mywidgets.displayToast(
                                      msg:
                                          "Got to the place before fire store");
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc("${provider.sp_user_id}")
                                      .set({
                                    "id": provider.sp_user_id,
                                    "first_name": provider.sp_first_name,
                                    "last_name": provider.sp_last_name,
                                    "user_type": "serviceProvider",
                                    "call_in_progress": false,
                                    "is_calling": false,
                                    "caller_name": "",
                                    "caller_img": "",
                                    "channel_name": "",
                                    "call_token": ""
                                  });

                                  // mywidgets.displayToast(msg: "$value");
                                  ///// Navigation.push to the OTP screen
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Bottombar(
                                                userType: provider.userType,
                                                user_id: (provider.userType ==
                                                        "serviceProvider")
                                                    ? provider.sp_user_id
                                                    : provider.client_user_id)),
                                    (route) => false,
                                  );
                                } else if (value["status"] == "Network Error") {
                                  mywidgets.displayToast(
                                      msg:
                                          "Network Error. Check your Network Connection and try again");
                                } else {
                                  // mywidgets.displayToast(msg: value["message"]);
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              });
                            } else if (value["status"] == "Network Error") {
                              mywidgets.displayToast(
                                  msg:
                                      "Network Error. Check your Network Connection and try again");
                            } else {
                              // mywidgets.displayToast(msg: value["message"]);
                            }

                            // setState(() {
                            //   isLoading = false;
                            // });
                          });
                        }

                        //will save this parameter to state management later
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 50,
                        decoration: BoxDecoration(
                            color: (imgPath.isEmpty ||
                                    bioController.text.isEmpty ||
                                    dropdownvalueServices == null ||
                                    dropdownvalueSkills == null ||
                                    dropdownValueExperience == null)
                                ? Color(0XFFF3F4F6)
                                : constants.appMainColor,
                            borderRadius: BorderRadius.circular(200)),
                        child: Center(
                          child: (isLoading)
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Submit",
                                  style: GoogleFonts.inter(
                                      color: (imgPath.isEmpty ||
                                              bioController.text.isEmpty ||
                                              dropdownvalueServices == null ||
                                              dropdownvalueSkills == null ||
                                              dropdownValueExperience == null)
                                          ? Color(0XFF6B7280)
                                          : Colors.white,
                                      fontSize: 14),
                                ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    )

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

  void _detectWordCount() {
    final text = bioController.text;
    if (text.isEmpty) {
      setState(() {
        wordCount = 0;
      });
    } else {
      final words = text.split(RegExp(r'\s+'));
      setState(() {
        wordCount = words.length;
      });
    }
  }

  TextEditingValue customInputFormatter(
      TextEditingValue oldValue, TextEditingValue newValue, int maxWordCount) {
    final oldText = oldValue.text;
    final newText = newValue.text;

    // Split the text by spaces to count words
    final oldWordCount = oldText.split(' ').length;
    final newWordCount = newText.split(' ').length;

    // Allow editing of the existing text but prevent new input when the word count reaches the limit
    if (newWordCount > maxWordCount) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}
