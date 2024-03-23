import 'dart:io';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/states.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dara_app/screens/homepage/searchPlace.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  int maxWordCount = 20;
  int wordCount = 0;
  String updatedImage = "";
  String imgPath = "";
  String imgExt = "";

  File? readyUploadImage;
  bool hasImg = false;

  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? phoneController;
  TextEditingController? emailAddressController;
  TextEditingController? bioController;

  String? dropdownvalueCountry;
  String? dropdownvalueState;
  String? dropdownvalueLGA;
  List? country = ['Nigeria'];

  List? state = [];

  List? localGovernmentArea = [];

  TextEditingController specificAddressController = TextEditingController();

  @override
  void initState() {
    states.forEach((e) {
      setState(() {
        state!.add(e["state"]);
      });
    });

    DataProvider provider = Provider.of<DataProvider>(context, listen: false);
    super.initState();
    firstNameController = TextEditingController(
        text:
            "${provider.value["user_object"]["personal_information"]["first_name"]}");
    lastNameController = TextEditingController(
        text:
            "${provider.value["user_object"]["personal_information"]["last_name"]}");
    phoneController = TextEditingController(
        text:
            "${provider.value["user_object"]["personal_information"]["phone"]}");
    emailAddressController = TextEditingController(
        text:
            "${provider.value["user_object"]["personal_information"]["email"]}");
    bioController = TextEditingController(text: "");

    specificAddressController = TextEditingController(
        text:
            "${provider.value["user_object"]["address_information"]["address"]}");

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
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Text("")),
          centerTitle: false,
          titleSpacing: 0,
          title: Transform(
            transform: Matrix4.translationValues(-55, 0, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                                onPressed: () {
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
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Personal Information",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),

                Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: readyUploadImage == null
                          ? Image.network(
                              "${provider.value["user_object"]["address_information"]["profile_image"]}",
                              fit: BoxFit.cover)
                          : Image.file(File(readyUploadImage!.path)),
                    )),

                // Add/Change Image
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add/Change Image",
                          style: TextStyle(fontSize: 12),
                        ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Select file",
                                  style: TextStyle(fontSize: 14),
                                ),
                                InkWell(
                                  onTap: () {
                                    /////////// Call the pick image method and change the image to replace the icon
                                    getImageGallery();
                                  },
                                  child: Text(
                                    "Upload Passport Photo",
                                    style: TextStyle(
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

                // First Name
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1, color: Color(0XFFE5E7EB))),
                          child: TextFormField(
                            // focusNode: textNode,
                            onChanged: (value) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: firstNameController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when enabled
                              ),
                              hintText: "Enter your first name",
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

                // last name
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Name",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1, color: Color(0XFFE5E7EB))),
                          child: TextFormField(
                            // focusNode: textNode,
                            onChanged: (value) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: lastNameController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when enabled
                              ),
                              hintText: "Enter your last name",
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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone number",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1, color: Color(0XFFE5E7EB))),
                          child: TextFormField(
                            // focusNode: textNode,
                            onChanged: (value) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.number,
                            enabled: false,
                            controller: phoneController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when enabled
                              ),
                              hintText: "Enter your phone number",
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

                //Email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Address",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1, color: Color(0XFFE5E7EB))),
                          child: TextFormField(
                            // focusNode: textNode,
                            onChanged: (value) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailAddressController,
                            enabled: false,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when enabled
                              ),
                              hintText: "Enter your email Address",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                (provider.userType == "serviceProvider")
                    ? Column(
                        children: [
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
                        ],
                      )
                    : SizedBox(),

                (provider.userType == "client")
                    ? Column(
                        children: [
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
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0XFFE5E7EB))),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: TextFormField(
                                            enabled: false,
                                            // focusNode: textNode,
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller:
                                                specificAddressController,
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
                                                  "Specific location address",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),

                SizedBox(
                  height: 20,
                ),

                InkWell(
                  onTap: () {
                    // if (readyUploadImage == null) {
                    //  mywidgets.displayToast(msg:"Select Image to Update");
                    // }else{
                    circularCustom(context);
                    updatePersonalInfo(
                        imageFile: readyUploadImage,
                        first_name: firstNameController!.text,
                        last_name: lastNameController!.text,
                        phone: phoneController!.text,
                        email: emailAddressController!.text,
                        bio: bioController!.text)
                      ..then((value) {
                        print(value);

                        if (value["status"] == true) {
                          mywidgets.displayToast(msg: "Profile Updated");
                          reloadUserObject().then((value) {
                            if ((provider.userType == "serviceProvider")) {
                              provider.set_sp_login_info(
                                  value: value,
                                  firstName: value["user_object"]
                                      ["personal_information"]["first_name"],
                                  lastName: value["user_object"]
                                      ["personal_information"]["last_name"],
                                  email: value["user_object"]
                                      ["personal_information"]["email"],
                                  id: value["user_object"]
                                          ["personal_information"]["id"]
                                      .toString(),
                                  access_token: value["access_token"],
                                  profile_image: (value["user_object"]
                                              ["address_information"] !=
                                          null)
                                      ? value["user_object"]
                                              ["address_information"]
                                          ["profile_image"]
                                      : "");
                            } else {
                              provider.set_client_login_info(
                                  value: value,
                                  firstName: value["user_object"]
                                      ["personal_information"]["first_name"],
                                  lastName: value["user_object"]
                                      ["personal_information"]["last_name"],
                                  email: value["user_object"]
                                      ["personal_information"]["email"],
                                  id: value["user_object"]
                                          ["personal_information"]["id"]
                                      .toString(),
                                  access_token: value["access_token"],
                                  profile_image: (value["user_object"]
                                              ["address_information"] !=
                                          null)
                                      ? value["user_object"]
                                              ["address_information"]
                                          ["profile_image"]
                                      : "");
                            }
                          });
                        } else if (value["status"] == "Network Error") {
                          mywidgets.displayToast(
                              msg:
                                  "Network Error. Check your Network Connection and try again");
                        } else {
                          mywidgets.displayToast(msg: value["message"]);
                        }

                        Navigator.pop(context);
                      });
                    // }

                    //will save this parasmeter to state management later
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 50,
                    decoration: BoxDecoration(
                        color: constants.appMainColor,
                        borderRadius: BorderRadius.circular(200)),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ));
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
    final text = bioController!.text;
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
