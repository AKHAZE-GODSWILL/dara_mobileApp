import 'dart:io';
import 'package:dara_app/main.dart';
import '../homepage/bottomBar.dart';
import '../homepage/searchPlace.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/states.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/screens/homepage/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class ClientAddressInfo extends StatefulWidget {
  ClientAddressInfo({Key? key}) : super(key: key);

  @override
  State<ClientAddressInfo> createState() => _ClientAddressInfo();
}

class _ClientAddressInfo extends State<ClientAddressInfo> {
  String updatedImage = "";
  String imgPath = "";
  String imgExt = "";

  File? readyUploadImage;
  bool hasImg = false;

  final specificAddressController = TextEditingController();

  String? dropdownvalueCountry = "Nigeria";
  String? dropdownvalueState;
  String? dropdownvalueLGA;
  List? country = ["Nigeria"];

  List? state = [];

  List? localGovernmentArea = [];

  final textNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool isObscured = false;
  bool isLoading = false;

  @override
  void initState() {
    states.forEach((e) {
      setState(() {
        state!.add(e["state"]);
      });
    });

    isObscured = true;

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    specificAddressController.dispose();
    super.dispose();
  }

  filterLga() {
    setState(() {
      List new_localGovernmentArea = states.singleWhere((element) =>
          element["state"].toString().toLowerCase() ==
          dropdownvalueState.toString().toLowerCase())["lga"];
      new_localGovernmentArea.forEach((element) {
        localGovernmentArea!.add(element["name"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Address Information",
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
                          "50%",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
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
                            "You're Almost Done",
                            style: GoogleFonts.inter(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Enhance your Dara experience by connecting with service providers for your needs. Follow these steps to maximize platform benefits.",
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
                              decoration: BoxDecoration(shape: BoxShape.circle),
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
                            Text("Add/Change Image",
                                style: GoogleFonts.inter(
                                    fontSize: 12, color: Color(0XFF6B7280))),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1, color: Color(0XFFE5E7EB))),
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
                                        "Upload Passport Photo",
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: constants.appMainColor),
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

                    // Country
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Country",
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Color(0XFF6B7280)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Color(0XFFE5E7EB))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black38,
                                    ),
                                    hint: Text('Select Your Country',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Color(0XFF6B7280))),
                                    items: country!
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: dropdownvalueCountry,
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownvalueCountry = value as String;
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

                    // State
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State",
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Color(0XFF6B7280)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Color(0XFFE5E7EB))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black38,
                                    ),
                                    hint: Text('Select Your State',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Color(0XFF6B7280))),
                                    items: state!
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: dropdownvalueState,
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownvalueState = value as String;
                                        filterLga();
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

                    //Area
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Area(L.G.A)",
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Color(0XFF6B7280)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Color(0XFFE5E7EB))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black38,
                                    ),
                                    hint: Text(
                                        'Select Your Local Government Area',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Color(0XFF6B7280))),
                                    items: localGovernmentArea!
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: dropdownvalueLGA,
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownvalueLGA = value as String;
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

                    //Specific Address
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Specific Address",
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Color(0XFF6B7280)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SearchPlace(title: "Address");
                                    },
                                  ),
                                ).then((place) {
                                  setState(() {
                                    specificAddressController.text =
                                        place["mainText"];
                                  });
                                });
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1, color: Color(0XFFE5E7EB))),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextFormField(
                                        enabled: false,
                                        // focusNode: textNode,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: specificAddressController,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide
                                                .none, // Remove the border when focused
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide
                                                .none, // Remove the border when enabled
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide
                                                .none, // Remove the border when enabled
                                          ),
                                          hintText:
                                              "Enter your specific location address",
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return SearchPlace(
                                                  title: "Address");
                                            },
                                          ),
                                        ).then((place) {
                                          setState(() {
                                            specificAddressController.text =
                                                place["mainText"];
                                          });
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Icon(
                                          PhosphorIcons.map_pin,
                                          size: 20,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )
                                  ],
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
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: () {
                  /////////////////// Push to the next page after user has selected a tier

                  if (dropdownvalueCountry != null &&
                      dropdownvalueState != null &&
                      dropdownvalueLGA != null &&
                      specificAddressController.text.isNotEmpty &&
                      imgPath.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });

                    // makes the request here
                    userAddressInformation(
                            imageFile: File(imgPath),
                            country: dropdownvalueCountry,
                            state: dropdownvalueState,
                            area: dropdownvalueLGA,
                            specificAddress:
                                specificAddressController.text.trim(),
                            user_id: provider.client_user_id)
                        .then((value) {
                      if (value["status"] == true) {
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc("${provider.client_user_id}")
                            .set({
                          "id": provider.client_user_id,
                          "first_name": provider.client_first_name,
                          "last_name": provider.client_last_name,
                          "user_type": "client",
                          "call_in_progress": false,
                          "is_calling": false,
                          "caller_name": "",
                          "caller_img": "",
                          "channel_name": "",
                          "call_token": ""
                        });

                        getX.write(constants.GETX_LOGGED_IN, true);

                        /// Navigation.push to the OTP screen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Bottombar(
                                  userType: provider.userType,
                                  user_id:
                                      (provider.userType == "serviceProvider")
                                          ? provider.sp_user_id
                                          : provider.client_user_id)),
                          (route) => false,
                        );
                      } else if (value["status"] == "Network Error") {
                        mywidgets.displayToast(
                            msg:
                                "Network Error. Check your Network Connection and try again");
                      } else {
                        mywidgets.displayToast(msg: value["message"]);
                      }

                      setState(() {
                        isLoading = false;
                      });
                    });
                  }

                  /// Navigation.push to the OTP screen

                  //will save this parameter to state management later
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 50,
                  decoration: BoxDecoration(
                      color: (dropdownvalueCountry == null ||
                              dropdownvalueState == null ||
                              dropdownvalueLGA == null ||
                              specificAddressController.text.isEmpty ||
                              imgPath.isEmpty)
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
                            style: TextStyle(
                                color: (dropdownvalueCountry == null ||
                                        dropdownvalueState == null ||
                                        dropdownvalueLGA == null ||
                                        specificAddressController
                                            .text.isEmpty ||
                                        imgPath.isEmpty)
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
}
