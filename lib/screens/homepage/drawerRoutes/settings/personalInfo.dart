import 'dart:io';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailAddressController = TextEditingController();
  final bioController = TextEditingController();
  final specificAddressController = TextEditingController();

  String? dropdownvalueCountry;
  String? dropdownvalueState;
  String? dropdownvalueLGA;
  var country = [
    'Nigeria',
    "Ghana",
    "South Africa",
    "USA",
    "Other Countries would be gotten from Api",
  ];

  var state = [
    'Lagos',
    "Cairo",
    "Kampala",
    "Texas",
    "Other States would be gotten from Api",
  ];

  var localGovernmentArea = [
    'Egor',
    "Surulere",
    "Uselu",
    "Mushin",
    "Other Local Government Areas would be gotten from Api",
  ];

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
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
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
                      child:
                          Image.asset("assets/profile.png", fit: BoxFit.cover),
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
                                    print(
                                        ">>>>>>>>>>>> Printing the get image place");
                                  },
                                  child: Text(
                                    "Upload Image",
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

                          // Country
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Country",
                                    style: TextStyle(fontSize: 12),
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
                                            'Select Your Country',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          items: country
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
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
                                              dropdownvalueCountry =
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

                          // State
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "State",
                                    style: TextStyle(fontSize: 12),
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
                                            'Select Your State',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          items: state
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
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
                                              dropdownvalueState =
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

                          //Area
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Area(L.G.A)",
                                    style: TextStyle(fontSize: 12),
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
                                            'Select Your Local Government Area',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          items: state
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
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
                                              dropdownvalueLGA =
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
                                    child: TextFormField(
                                      // focusNode: textNode,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.emailAddress,
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
                                        hintText:
                                            "Enter your specific location address",
                                      ),
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
                    Navigator.pop(context);

                    //will save this parameter to state management later
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
