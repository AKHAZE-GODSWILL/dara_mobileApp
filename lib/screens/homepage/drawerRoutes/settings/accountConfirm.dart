import '../../../../main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AccountConfirm extends StatefulWidget {
  const AccountConfirm({Key? key}) : super(key: key);

  @override
  State<AccountConfirm> createState() => _AccountConfirmState();
}

class _AccountConfirmState extends State<AccountConfirm> {
  String? dropdownvalueBankName;
  var bankName = [
    'First Bank',
    "UBA",
    "Fidelity",
    "Guaranty Trust Bank",
    "Other Banks would be gotten from Api",
  ];

  final accountNumberController = TextEditingController();
  final accountNameController = TextEditingController();

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
                    "Withdrawal Account",
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
                  height: 124,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: constants.appMainColor,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 72,
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Micheal Traore",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "First Bank - 011112111321",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 74.68,
                            height: 104,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/daraLogoGrey.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  // Navigator.pop(context);

                  showUpdateAccSheet();
                  //will save this parameter to state management later
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 50,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: constants.appMainColor),
                      borderRadius: BorderRadius.circular(200)),
                  child: Center(
                    child: Text(
                      "Update Details",
                      style: TextStyle(
                          color: constants.appMainColor, fontSize: 14),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Need help? ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                          text: 'Reach out to our support team',
                          style: TextStyle(
                            color: constants.appMainColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the tap gesture for 'World!'

                              Navigator.pop(context);
                              print('Terms and conditions tapped');
                            }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ));
  }

  showUpdateAccSheet() {
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
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Container(
                height: 450,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Update Account Details",
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    //Account Number
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account Number",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF6B7280)),
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
                                controller: accountNumberController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide
                                          .none, // Remove the border when focused
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide
                                          .none, // Remove the border when enabled
                                    ),
                                    hintText: "Enter your account number",
                                    hintStyle: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Color(0XFF6B7280))),
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
                              "Account Name",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF6B7280)),
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
                                keyboardType: TextInputType.text,
                                controller: accountNameController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide
                                          .none, // Remove the border when focused
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide
                                          .none, // Remove the border when enabled
                                    ),
                                    hintText: "Enter your account name",
                                    helperStyle: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Color(0XFF6B7280))),
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
                            Text("Bank",
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFF6B7280))),
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
                                    hint: Text('Select Bank',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Color(0XFF6B7280))),
                                    items: bankName
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
                                    value: dropdownvalueBankName,
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownvalueBankName = value as String;
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
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () {
                          // setState(() {
                          //   isSelected = false;
                          // });
                          // Navigator.pop(context);
                          // showDoneSheet();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
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
                    )
                  ],
                )),
          );
        });
      },
    );
  }
}
