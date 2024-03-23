import '../../../../main.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddBank extends StatefulWidget {
  List? banks;
  AddBank({this.banks});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  TextEditingController? accountController;
  TextEditingController? passwordController;
  TextEditingController? nameController;

  final securityAnswerController = TextEditingController();
  Map? dropdownvalueBank;
  String? dropdownvalueBankValue;

  @override
  void initState() {
    super.initState();
    accountController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    setState(() {
      dropdownvalueBank = widget.banks![0];
      dropdownvalueBankValue = widget.banks![0]["name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    "Banks",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bio
                      Text(
                        "Complete the form below to add bank for withdrawal.",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
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
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Destination",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: Color(0XFFE5E7EB))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black38,
                              ),
                              hint: Text('Select Your Bank',
                                  style: GoogleFonts.inter(
                                      fontSize: 14, color: Color(0XFF6B7280))),
                              items: widget.banks!
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item["name"],
                                        child: Text(item["name"].toString(),
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: Colors.black)),
                                      ))
                                  .toList(),
                              value: dropdownvalueBankValue.toString(),
                              onChanged: (value) {
                                setState(() {
                                  dropdownvalueBank = widget.banks!.singleWhere(
                                          (element) => element["name"] == value)
                                      as Map;
                                  dropdownvalueBankValue = value;
                                 
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.accountNumber ?? "Account Number",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: Color(0XFFE5E7EB))),
                        child: TextFormField(
                          // focusNode: textNode,
                          onChanged: (value) {
                            if (value.toString().length == 10) {
                              circularCustom(context);
                              validateAccount(value, dropdownvalueBank!["code"])
                                  .then((value) {
                                Navigator.pop(context);
                                if (value["status"] == false) {
                                  Fluttertoast.showToast(
                                      msg: value["message"],
                                      gravity: ToastGravity.BOTTOM);
                                } else {
                                  setState(() {
                                    nameController!.text =
                                        value["data"]["account_name"];
                                  });
                                }
                              });
                            }
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: accountController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when enabled
                              ),
                              hintText: "123456789",
                              hintStyle: TextStyle(color: Colors.black54)),
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
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Name",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: Color(0XFFE5E7EB))),
                        child: TextFormField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when enabled
                              ),
                              hintText: "",
                              hintStyle: TextStyle(color: Colors.black54)),
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
                  circularCustom(context);
                  saveBankAccount(
                          account_name: nameController!.text,
                          account_number: accountController!.text,
                          bank: dropdownvalueBank!["code"])
                      .then((value) {
                    Navigator.pop(context);

                    if (value["status"] == true) {
                      Navigator.of(context).pop();
                    } else if (value["status"] == "Network Error") {
                      mywidgets.displayToast(
                          msg:
                              "Network Error. Check your Network Connectxion and try again");
                    } else {
                      mywidgets.displayToast(msg: value["message"]);
                    }
                  });
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
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  CustomSecurityQuestionWidget() {
    return showDialog(
        barrierColor: Color(0XFF121212).withOpacity(0.7),
        context: context,
        builder: (context) {
          DataProvider provider =
              Provider.of<DataProvider>(context, listen: true);
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.9,
                    // height: 338,
                    // width: 320,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Security Question",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            provider.securityQuestion ??
                                "What is your Mother's Maiden Name?",
                            style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: Color(0XFF374151),
                                decoration: TextDecoration.none),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Material(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
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
                                keyboardType: TextInputType.text,
                                controller: securityAnswerController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide
                                          .none, // Remove the border when focused
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide
                                          .none, // Remove the border when enabled
                                    ),
                                    hintText: "Enter Security Answer",
                                    helperStyle: TextStyle(
                                      color: Colors.black54,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              /////////////////// Push to the next page after user has selected a tier

                              // if(_textEditingController!.text.isNotEmpty){
                              //   ///// Navigation.push to the OTP screen

                              // }
                              Navigator.pop(context);
                              Navigator.pop(context);

                              //will save this parameter to state management later
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              decoration: BoxDecoration(
                                  // color: (_textEditingController!.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                                  color: constants.appMainColor,
                                  borderRadius: BorderRadius.circular(200)),
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.inter(
                                      // color: (_textEditingController!.text.isEmpty)? Color(0XFF6B7280):Colors.white,
                                      color: Colors.white,
                                      fontSize: 14,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
