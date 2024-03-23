import 'dart:io';
import '../../../../main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class GetVerified extends StatefulWidget {
  const GetVerified({Key? key}) : super(key: key);

  @override
  State<GetVerified> createState() => _GetVerifiedState();
}

class _GetVerifiedState extends State<GetVerified> {
  String? dropdownvalueIDType;
  String updatedImage = "";

  List<Map<String, String>> filesInfo = [
    {"path": "", "type": ""},
    {"path": "", "type": ""},
    {"path": "", "type": ""},
  ];

  File? readyUploadImage;

  var id_type = [
    "National ID Card",
    // "International passport",
    "Voter's card",
    "Driver's License",
    // "Certificate of cooperation",
  ];

  final idNumberController = TextEditingController();
  final specificAddressController = TextEditingController();

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
                    "Get Verified",
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
        body: "${provider.value["user_object"]["personal_information"]["kyc"]}"
                    .toString() == "submitted"
              
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pending,
                    color: Colors.orange,
                    size: 100,
                  ),
                  Text(
                    "Kyc is under review",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              )):
"${provider.value["user_object"]["personal_information"]["kyc"]}"
                    .toString() == "approved"?
              Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.gpp_good,
                    color: Colors.green,
                    size: 100,
                  ),
                  Text(
                    "Account Verified",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
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
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child: Text(
                            "To verify your Dara service provider account, please complete the form below with essential information.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Text(
                                "1. Identity Verification",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          // ID Type
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ID Type",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
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
                                            'Select ID Type',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          items: id_type
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
                                          value: dropdownvalueIDType,
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownvalueIDType =
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

                          Column(children: [
                            // Bio
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upload Photo of ID (front)",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(8),
                                      dashPattern: [10, 10],
                                      color: Color(0XFFE5E7EB),
                                      strokeWidth: 2,
                                      child: Container(
                                        height: 96,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Container(
                                                  // color: Colors.red,
                                                  height: 72,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Upload ID",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "Please ensure that this image corresponds with the ID Type you selected above",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              (filesInfo[0]["path"]!.isEmpty)
                                                  ? PopupMenuButton<String>(
                                                      onSelected: (value) {
                                                        // Handle the selected option here

                                                        if (value ==
                                                            "Option 1") {
                                                          getImageCamera(
                                                              index: 0);
                                                        } else if (value ==
                                                            "Option 2") {
                                                          getImageGallery(
                                                              index: 0);
                                                        } else {
                                                          _pickFile(index: 0);
                                                        }
                                                      },
                                                      itemBuilder: (BuildContext
                                                          context) {
                                                        return <PopupMenuEntry<
                                                            String>>[
                                                          PopupMenuItem<String>(
                                                            value: 'Option 1',
                                                            child: Text(
                                                                'Take photo from Camera'),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            value: 'Option 2',
                                                            child: Text(
                                                                'Choose photo from Gallery'),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            value: 'Option 3',
                                                            child: Text(
                                                                'Attach File'),
                                                          ),
                                                        ];
                                                      },
                                                      child: SvgPicture.asset(
                                                          "assets/svg/camera@2x.svg"), // Icon for the dropdown menu
                                                    )
                                                  : (filesInfo[0]["type"] ==
                                                          "photo")
                                                      ? customImageWidget(
                                                          index: 0)
                                                      : customFileWidget(
                                                          index: 0)
                                            ]),
                                      ),
                                    )
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
                                    Text(
                                      "Upload Photo of ID (back)",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(8),
                                      dashPattern: [10, 10],
                                      color: Color(0XFFE5E7EB),
                                      strokeWidth: 2,
                                      child: Container(
                                        height: 96,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Container(
                                                  // color: Colors.red,
                                                  height: 72,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Upload ID",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "Please ensure that this image corresponds with the ID Type you selected above",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              (filesInfo[1]["path"]!.isEmpty)
                                                  ? PopupMenuButton<String>(
                                                      onSelected: (value) {
                                                        // Handle the selected option here

                                                        if (value ==
                                                            "Option 1") {
                                                          getImageCamera(
                                                              index: 1);
                                                        } else if (value ==
                                                            "Option 2") {
                                                          getImageGallery(
                                                              index: 1);
                                                        } else {
                                                          _pickFile(index: 1);
                                                        }
                                                      },
                                                      itemBuilder: (BuildContext
                                                          context) {
                                                        return <PopupMenuEntry<
                                                            String>>[
                                                          PopupMenuItem<String>(
                                                            value: 'Option 1',
                                                            child: Text(
                                                                'Take photo from Camera'),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            value: 'Option 2',
                                                            child: Text(
                                                                'Choose photo from Gallery'),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            value: 'Option 3',
                                                            child: Text(
                                                                'Attach File'),
                                                          ),
                                                        ];
                                                      },
                                                      child: SvgPicture.asset(
                                                          "assets/svg/camera@2x.svg"), // Icon for the dropdown menu
                                                    )
                                                  : (filesInfo[1]["type"] ==
                                                          "photo")
                                                      ? customImageWidget(
                                                          index: 1)
                                                      : customFileWidget(
                                                          index: 1)
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Text(
                                "2. Business Verification (CAC)",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Upload Photo of Certificate",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(8),
                                    dashPattern: [10, 10],
                                    color: Color(0XFFE5E7EB),
                                    strokeWidth: 2,
                                    child: Container(
                                      height: 96,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Container(
                                                // color: Colors.red,
                                                height: 80,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Upload Document",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Please ensure to upload a document that aligns well with your skills and showcase your expertise.",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            (filesInfo[2]["path"]!.isEmpty)
                                                ? PopupMenuButton<String>(
                                                    onSelected: (value) {
                                                      // Handle the selected option here

                                                      if (value == "Option 1") {
                                                        getImageCamera(
                                                            index: 2);
                                                      } else if (value ==
                                                          "Option 2") {
                                                        getImageGallery(
                                                            index: 2);
                                                      } else {
                                                        _pickFile(index: 2);
                                                      }
                                                    },
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return <PopupMenuEntry<
                                                          String>>[
                                                        PopupMenuItem<String>(
                                                          value: 'Option 1',
                                                          child: Text(
                                                              'Take photo from Camera'),
                                                        ),
                                                        PopupMenuItem<String>(
                                                          value: 'Option 2',
                                                          child: Text(
                                                              'Choose photo from Gallery'),
                                                        ),
                                                        PopupMenuItem<String>(
                                                          value: 'Option 3',
                                                          child: Text(
                                                              'Attach File'),
                                                        ),
                                                      ];
                                                    },
                                                    child: SvgPicture.asset(
                                                        "assets/svg/camera@2x.svg"), // Icon for the dropdown menu
                                                  )
                                                : (filesInfo[2]["type"] ==
                                                        "photo")
                                                    ? customImageWidget(
                                                        index: 2)
                                                    : customFileWidget(index: 2)
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                     

                          if (filesInfo[0]["path"].toString().isNotEmpty ||
                              filesInfo[1]["path"].toString().isNotEmpty ||
                              filesInfo[2]["path"].toString().isNotEmpty) {
                            DataProvider provider = Provider.of<DataProvider>(
                                context,
                                listen: false);

                            circularCustom(context);

                            updateKyc(
                              id_image_front:
                                  filesInfo[0]["path"].toString().isEmpty
                                      ? File(filesInfo[2]["path"].toString())
                                      : File(filesInfo[0]["path"].toString()),
                              id_image_back:
                                  filesInfo[1]["path"].toString().isEmpty
                                      ? File(filesInfo[2]["path"].toString())
                                      : File(filesInfo[1]["path"].toString()),
                              cac: filesInfo[2]["path"].toString().isEmpty
                                  ? File(filesInfo[0]["path"].toString())
                                  : File(filesInfo[2]["path"].toString()),
                              id_number: idNumberController.text,
                              id_type: dropdownvalueIDType,
                            ).then((value) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Updated Successfully");
                              reloadUserObject().then((value) {
                                if ((provider.userType == "serviceProvider")) {
                                  provider.set_sp_login_info(
                                      value: value,
                                      firstName: value["user_object"]
                                              ["personal_information"]
                                          ["first_name"],
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
                                              ["personal_information"]
                                          ["first_name"],
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
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Choose Image front/back and Upload CAC document");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 50,
                          decoration: BoxDecoration(
                              color: constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)),
                          child: Center(
                            child: Text(
                              "Submit",
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

  customImageWidget({required index}) {
    return Container(
      height: 80,
      width: 80,
      // color: Colors.blue,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 70,
              width: 70,
              // color: Colors.green,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(File(filesInfo[index]["path"]!),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  filesInfo[index]["path"] = "";
                  filesInfo[index]["type"] = "";
                });
              },
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  customFileWidget({required index}) {
    return Container(
      height: 80,
      width: 80,
      // color: Colors.blue,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Icon(
                  Icons.file_copy,
                  size: 50,
                ),
              ),
              Container(
                height: 20,
                width: 50,
                child: Text(
                  path.basename(
                    filesInfo[index]["path"]!,
                  ),
                  style: GoogleFonts.inter(fontSize: 5),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  filesInfo[index]["path"] = "";
                  filesInfo[index]["type"] = "";
                });
              },
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getImageGallery({required index}) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((selectedImage) {
      if (selectedImage == null) return;

      readyUploadImage = File(selectedImage.path);
      setState(() {
        filesInfo[index]["path"] = selectedImage.path!;
        filesInfo[index]["type"] = "photo";
      });
    });
  }

  getImageCamera({required index}) {
    ImagePicker().pickImage(source: ImageSource.camera).then((selectedImage) {
      if (selectedImage == null) return;

      readyUploadImage = File(selectedImage.path);
      setState(() {
        filesInfo[index]["path"] = selectedImage.path!;
        filesInfo[index]["type"] = "photo";
      });
    });
  }

  Future<void> _pickFile({required index}) async {
    await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      "pdf",
      "doc",
      "docX",
      "xls",
      "xlsx",
      "ppt",
      "pptx",
      "txt",
      "rtf",
      "csv",
      "htm",
      "html",
      "xml",
      "json",
      "md",
      "markdown",
      "tex",
      "odt",
      "ods",
      "odp"
    ]).then((result) {
      if (result != null) {
        setState(() {
          filesInfo[index]["path"] = result.files.single.path!;
          filesInfo[index]["type"] = "document";
        });
      }
    });
  }
}
