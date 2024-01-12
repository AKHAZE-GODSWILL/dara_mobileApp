import 'dart:convert';
import 'package:dara_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/screens/authentication/forgotPassword.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
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
  bool isLoading = false;

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
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  "Change Password",
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
                    "Current Password",
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
                      obscureText: isCurrentPasswordObscured,
                      focusNode: currentPasswordFocusNode,
                      keyboardType: TextInputType.text,
                      controller: currentPasswordController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide.none, // Remove the border when enabled
                        ),
                        hintText: "Enter Password",
                        suffixIcon: IconButton(
                            padding: EdgeInsetsDirectional.only(end: 12),
                            icon: isCurrentPasswordObscured
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isCurrentPasswordObscured =
                                    !isCurrentPasswordObscured;
                              });
                            }),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          currentPasswordFocusNode.requestFocus();
                          return "Please enter some text";
                        }
                        if (value.length < 6) {
                          currentPasswordFocusNode.requestFocus();
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
                        hintText: "Enter Password",
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
                    "Retype Password",
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
                        hintText: "Enter Password",
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

              if (currentPasswordController!.text.isNotEmpty &&
                  newPasswordController.text.isNotEmpty &&
                  retypePasswordController.text.isNotEmpty) {
                ///// Navigation.push to the OTP screen
                // Navigator.pop(context);

                if (newPasswordController.text.trim() !=
                    retypePasswordController.text.trim()) {
                  mywidgets.displayToast(
                      msg: "New Password and Retype password must match");
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  String currentPassword = (provider.userType ==
                          "serviceProvider")
                      ? decryptPassword(getX.read(constants.GETX_SP_PASSWORD))
                      : decryptPassword(
                          getX.read(constants.GETX_CLIENT_PASSWORD));

                  if (currentPassword ==
                      currentPasswordController!.text.trim()) {
                    //make the request to change password here

                    // makes the request here
                    resetPassword(
                            newPassword: newPasswordController.text.trim(),
                            confirmedPassword:
                                retypePasswordController.text.trim(),
                            user_id: (provider.userType == "serviceProvider")
                                ? provider.sp_user_id
                                : provider.client_user_id)
                        .then((value) {
                      print(
                          "The final Value of what was resulted from the request was :$value");

                      if (value["status"] == true) {
                        String encryptedPassword = encryptPassword(
                            currentPasswordController.text.trim());

                        getX.write(
                            (provider.userType == "serviceProvider")
                                ? constants.GETX_SP_PASSWORD
                                : constants.GETX_CLIENT_PASSWORD,
                            encryptedPassword);
                        mywidgets.displayToast(
                            msg: "Password changed successfully");
                        Navigator.pop(context);
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
                  } else {
                    mywidgets.displayToast(
                        msg:
                            "Current Password is Incorrect. Click forgot Password to change your password");
                  }
                }
              }

              //will save this parameter to state management later
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              decoration: BoxDecoration(
                  color: (currentPasswordController.text.isEmpty ||
                          newPasswordController.text.isEmpty ||
                          retypePasswordController.text.isEmpty)
                      ? Color(0XFFF3F4F6)
                      : constants.appMainColor,
                  borderRadius: BorderRadius.circular(200)),
              child: Center(
                child: (isLoading)
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "Save",
                        style: TextStyle(
                            color: (currentPasswordController.text.isEmpty ||
                                    newPasswordController.text.isEmpty ||
                                    retypePasswordController.text.isEmpty)
                                ? Color(0XFF6B7280)
                                : Colors.white,
                            fontSize: 14),
                      ),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 12),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Forgot Password?',
                      style: TextStyle(
                        color: constants.appMainColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the tap gesture for 'World!'

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                          print('Terms and conditions tapped');
                        }),
                ],
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

          // Padding(padding: )
        ],
      ),
    );
  }

  String encryptPassword(String password) {
    // Generate a random IV for encryption
    final iv = encrypt.IV.fromSecureRandom(16);

    final privateKey =
        encrypt.Key(Uint8List.fromList(utf8.encode(constants.encryptionKey)));
    final encrypter = encrypt.Encrypter(encrypt.AES(privateKey));
    final encryptedPassword = encrypter.encrypt(password, iv: iv);

    // Store the encrypted key and IV alongside the encrypted password
    final encryptedData = {
      'password': encryptedPassword.base64,
      'iv': iv.base64,
    };

    return jsonEncode(encryptedData);
  }

  String decryptPassword(String encryptedData) {
    final privateKey =
        encrypt.Key(Uint8List.fromList(utf8.encode(constants.encryptionKey)));
    final encryptedDataMap = jsonDecode(encryptedData);

    final ivBytes = base64Decode(encryptedDataMap['iv']);
    final iv = encrypt.IV(Uint8List.fromList(ivBytes));

    final encrypter = encrypt.Encrypter(encrypt.AES(privateKey));
    final encryptedPassword =
        encrypt.Encrypted.fromBase64(encryptedDataMap['password']);

    // Decrypt and return the password
    return encrypter.decrypt(encryptedPassword, iv: iv);
  }
}
