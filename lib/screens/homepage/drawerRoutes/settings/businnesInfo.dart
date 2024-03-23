import 'dart:io';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({Key? key}) : super(key: key);

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  String? dropdownvalueServices;
  String? dropdownvalueSkills;
  String? dropdownvalueCountry;
  String? dropdownvalueState;
  String? dropdownvalueLGA;
  String? dropdownvalueExperience;
  TextEditingController? specificAddressController;

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

  List services = [];

  List skill = [];

  List servicesId = [];

  @override
  void initState() {
    DataProvider provider = Provider.of<DataProvider>(context, listen: false);
    print(provider.value["user_object"]);
    dropdownvalueLGA =
        provider.value["user_object"]["address_information"]["lga"];
    dropdownvalueSkills =
        provider.value["user_object"]["service_information"][0]["skills"];
    skill = [dropdownvalueSkills];
    dropdownvalueCountry =
        provider.value["user_object"]["address_information"]["country"];
    dropdownvalueState =
        provider.value["user_object"]["address_information"]["state"];
    specificAddressController = TextEditingController(
        text: provider.value["user_object"]["address_information"]["address"]);
    dropdownvalueServices =
        provider.value["user_object"]["service_information"][0]["service"];
    dropdownvalueExperience =
        provider.value["user_object"]["service_information"][0]["experience"];

    // imgPath_Cover_Url = provider.value["user_object"]["service_information"][0]
    //     ["service_image"];

    imgPath_Url =
        provider.value["user_object"]["address_information"]["profile_image"];

    states.forEach((e) {
      setState(() {
        state!.add(e["state"]);
      });
    });

    // TODO: implement initState
    getCategories().then((value) {
      setState(() {
        for (var i in value) {
          services.add(i["name"]);
          servicesId.add(i);
        }
      });
    });
    // getSkills().then((value) {
    //   setState(() {
    //     for (var i in value) {
    //       skill.add(i["skill"]);
    //     }
    //   });
    // });
    filterLga();
    super.initState();
  }

  List? country = ["Nigeria"];

  List? state = [];

  List? localGovernmentArea = [];

  final experienceController = TextEditingController();

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

  String updatedImage = "";
  String imgPath = "";

  String imgPath_Url = "";
  String imgExt = "";
  String imgExt_Cover = "";

  File? readyUploadImage;
  File? readyUploadImage_Cover;
  bool hasImg = false;
  bool hasImg_Cover = false;

  getImageGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((selectedImage) {
      if (selectedImage == null) return;

      readyUploadImage = File(selectedImage.path);
      setState(() {
        imgPath = readyUploadImage!.path;
        imgExt = imgPath.split(".").last;
        hasImg = true;
        imgPath_Url = "";
      });

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             ProfilePic(imgPath: imgPath, updateUserImage: updateLocalProfilePic,))); //onSendImage
    });
  }

  // getImageGallery_Cover() {
  //   ImagePicker().pickImage(source: ImageSource.gallery).then((selectedImage) {
  //     if (selectedImage == null) return;

  //     readyUploadImage_Cover = File(selectedImage.path);
  //     setState(() {
  //       imgPath_Cover = readyUploadImage_Cover!.path;
  //       imgExt_Cover = imgPath_Cover.split(".").last;
  //       hasImg_Cover = true;
  //       imgPath_Cover_Url = "";
  //     });

  //     // Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //         builder: (context) =>
  //     //             ProfilePic(imgPath: imgPath, updateUserImage: updateLocalProfilePic,))); //onSendImage
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
                    "Business Information",
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
        body: services.isEmpty
            ? Center(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ))
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: imgPath_Url.isNotEmpty
                            ? Container(
                                width: 64,
                                height: 64,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: ClipOval(
                                  child: Image.network(imgPath_Url,
                                      fit: BoxFit.cover),
                                ))
                            : (imgPath.isEmpty)
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
                      // Services

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Services",
                                style: TextStyle(fontSize: 12),
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
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: dropdownvalueServices,
                                      onChanged: (value) {
                                        circularCustom(context);
                                        setState(() {
                                          dropdownvalueServices =
                                              value as String;
                                          getSpecificSkills(servicesId
                                                  .singleWhere((element) =>
                                                      element["name"]
                                                          .toString()
                                                          .toLowerCase() ==
                                                      value
                                                          .toString()
                                                          .toLowerCase())["id"])
                                              .then((value) {
                                            Navigator.pop(context);
                                            setState(() {
                                              skill = [];
                                              if (!skill.contains(
                                                  dropdownvalueSkills)) {
                                                skill.add(dropdownvalueSkills);
                                              }
                                              for (var i in value) {
                                                skill.add(i);
                                              }
                                            });
                                          });
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
                                style: TextStyle(fontSize: 12),
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
                                                  style: TextStyle(
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
                                "Experience",
                                style: TextStyle(fontSize: 12),
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
                                        'Select Your Experience',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      items: experienceList!
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
                                      value: dropdownvalueExperience,
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownvalueExperience =
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
                                        'Select Your Country',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      items: country!
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
                                        'Select Your State',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      items: state!
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
                                style: TextStyle(fontSize: 12),
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
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      items: localGovernmentArea!
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

                      SizedBox(
                        height: 20,
                      ),

                      InkWell(
                        onTap: () {
                          print(readyUploadImage_Cover);
                          print(readyUploadImage);
                          if (readyUploadImage == null) {
                            Fluttertoast.showToast(msg: "Select a picture");
                          } else {
                            circularCustom(context);
                            DataProvider provider = Provider.of<DataProvider>(
                                context,
                                listen: false);
                            updateAddressInfo(
                              imageFile: readyUploadImage,
                              country: dropdownvalueCountry,
                              state: dropdownvalueState,
                              lga: dropdownvalueLGA,
                              address: specificAddressController!.text,
                              user_id: provider.value["user_object"]
                                  ["personal_information"]["id"],
                              phone: provider.value["user_object"]
                                  ["personal_information"]["phone"].toString(),
                            ).then((value) => {

                              
                                  updateServiceInfo(
                                    imageFile: readyUploadImage,
                                    service: dropdownvalueServices,
                                    bio: provider.value["user_object"]
                                        ["service_information"][0]["bio"],
                                    skills: dropdownvalueSkills,
                                    user_id: provider.value["user_object"]
                                        ["personal_information"]["id"],
                                    experience: dropdownvalueExperience,
                                  ).then((value) {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg: "Updated Successfully");
                                    reloadUserObject().then((value) {
                                      if ((provider.userType ==
                                          "serviceProvider")) {
                                        provider.set_sp_login_info(
                                            value: value,
                                            firstName: value["user_object"]
                                                    ["personal_information"]
                                                ["first_name"],
                                            lastName: value["user_object"]
                                                    ["personal_information"]
                                                ["last_name"],
                                            email: value["user_object"]
                                                    ["personal_information"]
                                                ["email"],
                                            id: value["user_object"]
                                                        ["personal_information"]
                                                    ["id"]
                                                .toString(),
                                            access_token: value["access_token"],
                                            profile_image: (value["user_object"]["address_information"] != null)
                                                ? value["user_object"]
                                                        ["address_information"]
                                                    ["profile_image"]
                                                : "");
                                      } else {
                                        provider.set_client_login_info(
                                            value: value,
                                            firstName: value["user_object"]
                                                    ["personal_information"]
                                                ["first_name"],
                                            lastName: value["user_object"]
                                                    ["personal_information"]
                                                ["last_name"],
                                            email: value["user_object"]
                                                    ["personal_information"]
                                                ["email"],
                                            id: value["user_object"]
                                                        ["personal_information"]
                                                    ["id"]
                                                .toString(),
                                            access_token: value["access_token"],
                                            profile_image: (value["user_object"]["address_information"] != null)
                                                ? value["user_object"]
                                                        ["address_information"]
                                                    ["profile_image"]
                                                : "");
                                      }
                                    });
                                  })
                               
                               
                                });
                          }
                          //
                          // updateServiceInfo

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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
}
