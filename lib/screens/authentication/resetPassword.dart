import 'package:dara_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dara_app/widget/custom_circle.dart';

class ResetPassword extends StatefulWidget {
  String email;
  ResetPassword({required this.email});

  @override
  State<ResetPassword> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final _textEditingController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  final currentPasswordFocusNode = FocusNode();
  final newPasswordFocusNode = FocusNode();
  final retypePasswordFocusNode = FocusNode();

  bool isCurrentPasswordObscured = false;
  bool isNewPasswordObscured = false;
  bool isRetypePasswordObscured = false;

  @override
  void initState() {
    // TODO: implement initState

    isCurrentPasswordObscured = true;
    isNewPasswordObscured = true;
    isRetypePasswordObscured = true;

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _textEditingController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  "Reset Password",
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Enter New Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10),
                  child: Text(
                    "Please provide a new and preferred password for your account",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
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
                    "New Password",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Color(0XFFE5E7EB))),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      obscureText: isNewPasswordObscured,
                      focusNode: newPasswordFocusNode,
                      keyboardType: TextInputType.text,
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide.none, // Remove the border when enabled
                        ),
                        hintText: "Create new password",
                        suffixIcon: IconButton(
                            padding: EdgeInsetsDirectional.only(end: 12),
                            icon: isNewPasswordObscured
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isNewPasswordObscured = !isNewPasswordObscured;
                              });
                            }),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          newPasswordFocusNode.requestFocus();
                          return "Please enter some text";
                        }
                        if (value.length < 6) {
                          newPasswordFocusNode.requestFocus();
                          return "Password must be atleast 6 characters";
                        }
                      },
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
                    "Confirm password",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Color(0XFFE5E7EB))),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      obscureText: isRetypePasswordObscured,
                      focusNode: retypePasswordFocusNode,
                      keyboardType: TextInputType.text,
                      controller: retypePasswordController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide.none, // Remove the border when enabled
                        ),
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                            padding: EdgeInsetsDirectional.only(end: 12),
                            icon: isRetypePasswordObscured
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isRetypePasswordObscured =
                                    !isRetypePasswordObscured;
                              });
                            }),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          retypePasswordFocusNode.requestFocus();
                          return "Please enter some text";
                        }
                        if (value.length < 6) {
                          retypePasswordFocusNode.requestFocus();
                          return "Password must be atleast 6 characters";
                        }
                      },
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
              /////////////////// Push to the next page after user has selected a tier
              circularCustom(context);
              if (newPasswordController.text.isNotEmpty &&
                  retypePasswordController.text.isNotEmpty) {
                ///// Navigation.push to the OTP screen
                Navigator.pop(context);

                circularCustom(context);
                changePassword(
                        email: widget.email,
                        newPassword: newPasswordController.text.trim(),
                        confirmedPassword: retypePasswordController.text)
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  if (value["status"] == true) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ResetPassword(email: widget.email)));
                  } else if (value["status"] == "Network Error") {
                    mywidgets.displayToast(
                        msg:
                            "Network Error. Check your Network Connection and try again");
                  } else {
                    mywidgets.displayToast(msg: value["message"]);
                  }
                });
              }

              //will save this parameter to state management later
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              decoration: BoxDecoration(
                  color: (newPasswordController.text.isEmpty ||
                          retypePasswordController.text.isEmpty)
                      ? Color(0XFFF3F4F6)
                      : constants.appMainColor,
                  borderRadius: BorderRadius.circular(200)),
              child: Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                      color: (newPasswordController.text.isEmpty ||
                              retypePasswordController.text.isEmpty)
                          ? Color(0XFF6B7280)
                          : Colors.white,
                      fontSize: 14),
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

                          Future<void> _launchUrl() async {
                  final Uri _url =
                      Uri.parse('https://wa.me/message/MX5JENZMK2BBI1');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                }

                _launchUrl();
                        }),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 60,
          ),

          // Padding(padding: )
        ],
      ),
    );
  }
}
