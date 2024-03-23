import 'package:dara_app/main.dart';
import 'package:flutter/material.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:dara_app/screens/homepage/home.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Mywidget {
  void displayToast({required msg}) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.TOP);
  }

  Widget ownMessageCard({context, message}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
            ),
            color: constants.appMainColor,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 45, right: 10, top: 10, bottom: 25),
                  child: Text(message.message,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      )),
                ),
                Positioned(
                  bottom: 4,
                  right: 5,
                  child: Row(
                    children: [
                      Text("${message.time}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          )),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget replyCard({context, message}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
            ),
            color: Colors.white,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 45, top: 10, bottom: 25),
                  child: Text("${message.message}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      )),
                ),
                Positioned(
                  bottom: 4,
                  left: 10,
                  child: Row(
                    children: [
                      Text("${message.time}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          )),

                      // SizedBox(width: 4,),
                      // Text("Read",

                      //     style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 10,
                      //               )),

                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget ownPictureCard(context, imgPath, message){

  //     return Align(
  //       alignment: Alignment.centerRight,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
  //         child: Container(
  //           constraints: BoxConstraints(
  //             minHeight: 150,
  //             maxWidth: 230
  //           ),
  //           // width: MediaQuery.of(context).size.width/1.4,
  //           decoration: BoxDecoration(
  //             color: constants.purple,
  //             borderRadius: BorderRadius.circular(16)
  //           ),
  //           child: Column(

  //             children: [
  //               Container(
  //                 constraints: BoxConstraints(
  //                   minHeight: 150,
  //                   maxHeight: 200,
  //                   minWidth: 230,
  //                   maxWidth: 230
  //                   ),
  //                 margin: EdgeInsets.all(3),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(16)),
  //               child: ClipRRect(
  //               borderRadius: BorderRadius.circular(16),
  //               child: Image.file(
  //                         File(imgPath),
  //                         fit: BoxFit.cover),),

  //           ),

  //               message != null? Text("${message.message}",
  //                   style: TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.w400,
  //                           fontSize: 14,
  //                               )
  //               ): SizedBox(),
  //             ],

  //             // Card(

  //             //     margin: EdgeInsets.all(3),
  //             //     shape: RoundedRectangleBorder(
  //             //       borderRadius:BorderRadius.circular(16)
  //             //     ),
  //             //     child: Image.file(
  //             //       File(imgPath),
  //             //       fit: BoxFit.fill),
  //             //   ),
  //           ),
  //         ),
  //       ),
  //     );
  // }

  // Widget replyPictureCard(context, imgPath,message ){

  //     return Align(
  //       alignment: Alignment.centerLeft,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
  //         child: Container(
  //           constraints: BoxConstraints(
  //             minHeight: 150,
  //             maxWidth: 230
  //           ),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(16)
  //           ),
  //           child: Column(

  //             children: [
  //               Container(
  //                 constraints: BoxConstraints(
  //                   minHeight: 150,
  //                   maxHeight: 200,
  //                   minWidth: 230,
  //                   maxWidth: 230
  //                   ),
  //                 margin: EdgeInsets.all(3),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(16)),
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(16),
  //                 child: CachedNetworkImage(
  //                   imageUrl: imgPath,
  //                   imageBuilder: (context, imageProvider) => Container(
  //                     width: 180.0,
  //                     height: 180.0,
  //                     decoration: BoxDecoration(

  //                       image: DecorationImage(
  //                       image: imageProvider, fit: BoxFit.cover),
  //                     ),
  //                   ),
  //                   placeholder: (context, url) => CircularProgressIndicator(),
  //                   errorWidget: (context, url, error) => Icon(Icons.error),
  //                 ),
  //               ),

  //           ),

  //               message != null? Text("${message.message}",
  //                   style: TextStyle(
  //                           color: constants.appMainColor,
  //                           fontWeight: FontWeight.w400,
  //                           fontSize: 14,
  //                               )
  //               ): SizedBox(),
  //             ],

  //           ),
  //         ),
  //       ),
  //     );
  // }

  Widget ownAudioCard({context, message}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
            ),
            color: constants.appMainColor,
            child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 45, right: 10, top: 10, bottom: 25),
                    child: IconButton(
                        constraints: BoxConstraints(minWidth: 100),
                        onPressed: () {},
                        icon: Icon(Icons.play_circle))),
                Positioned(
                  bottom: 4,
                  right: 5,
                  child: Row(
                    children: [
                      Text("${message.time}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          )),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showHireSheet({context, required sp_id, required service}) {
    print(service);
    String? dropdownvalueProject = service;
    String message = "";
    String skillRequired = "";
    String price = "";

    // bool? isLoading = false;
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          bool isLoading = false;
          return Container(
              height: 500,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hire Service Provider",
                              style: GoogleFonts.inter(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "Feel free to leave a note for the service provider in the provided box.Provide a brief description of the project's nature and details.",
                                style: GoogleFonts.inter(
                                    fontSize: 12, color: Color(0XFF374151))),
                          ],
                        ),
                      ),
                    ),

                    /////// The Demacation //////////
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
                              height: 20,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Service Required",
                                style: GoogleFonts.inter(
                                    fontSize: 12, color: Color(0XFF6B7280)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.95,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Color(0XFFE5E7EB))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: service == "" || service == null
                                    ? DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black38,
                                          ),
                                          hint: Text('Select Skill',
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: Color(0XFF6B7280))),
                                          items: skill
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          value: dropdownvalueProject,
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownvalueProject = value;
                                            });
                                          },
                                          buttonHeight: 40,
                                          buttonWidth: 140,
                                          itemHeight: 40,
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          service,
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                      ),
                              ),
                            ),

                            /////// The Demacation //////////
                          ],
                        ),
                      ),
                    ),

                    /////// The Demacation //////////
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
                              "Message ",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF6B7280)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 209,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Color(0XFFE5E7EB))),
                              child: TextFormField(
                                // focusNode: textNode,
                                onChanged: (value) {
                                  message = value;
                                },
                                keyboardType: TextInputType.multiline,
                                textAlignVertical: TextAlignVertical.top,
                                maxLines: null,
                                expands: true,
                                minLines: null,
                                // controller: bioController,
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
                                      "Describe what you want the service provider to know",
                                  hintStyle: GoogleFonts.inter(
                                      fontSize: 12, color: Color(0XFF6B7280)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () {
                          print(message.isNotEmpty &&
                              dropdownvalueProject == null);

                          if (message.isNotEmpty &&
                              dropdownvalueProject != null) {
                            circularCustom(context);

                            setState(() {
                              isLoading = true;
                            });

                            makeOfferToSP(
                                    service_provider_id: sp_id,
                                    message: message.trim(),
                                    skill_needed: dropdownvalueProject!.trim())
                                .then((value) {
                              if (value["status"] == true &&
                                  value["message"] ==
                                      "Your offer has been submitted successfully.") {
                                mywidgets.displayToast(
                                    msg: "Offers sent successfully");
                                setState(() {});
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } else if (value["status"] == "Network Error") {
                                Navigator.pop(context);
                                mywidgets.displayToast(
                                    msg:
                                        "Network Error. Check your Network Connection and try again");
                              } else {
                                Navigator.pop(context);
                                mywidgets.displayToast(msg: value["message"]);
                              }

                              setState(() {
                                isLoading = false;
                              });
                            });
                          } else {}
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          decoration: BoxDecoration(
                              color: constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)),
                          child: Center(
                            child: (isLoading == true)
                                ? CircularProgressIndicator()
                                : Text(
                                    "Submit",
                                    style: GoogleFonts.inter(
                                        color: Colors.white, fontSize: 14),
                                  ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ));
        });
      },
    );
  }
}
