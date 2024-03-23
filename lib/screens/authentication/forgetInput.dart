import 'dart:convert';
import 'package:dara_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:dara_app/screens/homepage/bottomBar.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:dara_app/screens/authentication/addressInfo.dart';
import 'package:dara_app/screens/authentication/registration.dart';
import 'package:dara_app/screens/authentication/forgotPassword.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:dara_app/screens/authentication/clientAddressInfo.dart';
import 'package:dara_app/screens/authentication/registrationClient.dart';

class forgetInput extends StatefulWidget {
  forgetInput({Key? key}) : super(key: key);

  @override
  State<forgetInput> createState() => _forgetInput();
}

class _forgetInput extends State<forgetInput> {
  LocalAuthentication auth = LocalAuthentication();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: getX.read("email") ?? "");
  final phoneController = TextEditingController(text: getX.read("phone") ?? "");
  final passwordController = TextEditingController();
  final bool clientRegCompleted =
      getX.read(constants.GETX_CLIENT_REG_COMPLETED) ?? false;
  final bool serviceProviderRegCompleted =
      getX.read(constants.GETX_SP_REG_COMPLETED) ?? false;
  final bool isBiometricEnabled =
      getX.read(constants.GETX_BIOMETRICS_ENABLED) ?? false;
  String authorized = "Not authorized";

  final textNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool isLoading = false;
  bool isObscured = false;
  Country? initialCountry;
  String _selectedCountryFlag = "";
  String countryCallingCode = "";
  bool isPageLoading = false;

  String dropDownLoginField = "Phone";
  var loginField = ["Phone", "Email"];

  @override
  void initState() {
    // TODO: implement initState
    _getDefaultFlag();
    isObscured = true;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: (isPageLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Container(
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.1,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/daraLogo.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Forgot Account",
                          style: GoogleFonts.inter(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // State
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 48,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          // color: constants.appMainColor,
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
                            hint: Text('Login Field',
                                style: GoogleFonts.inter(
                                    fontSize: 14, color: Color(0XFF6B7280))),
                            items: loginField
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        // style:  GoogleFonts.inter(
                                        //   fontSize: 14,
                                        //   color: Colors.white
                                        // )
                                      ),
                                    ))
                                .toList(),
                            itemHighlightColor: Colors.black,
                            value: dropDownLoginField,
                            // style:  GoogleFonts.inter(
                            //               fontSize: 14,
                            //               color: Colors.white
                            //             ),

                            onChanged: (value) {
                              setState(() {
                                dropDownLoginField = value as String;
                              });
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login ID",
                          style: GoogleFonts.inter(
                              fontSize: 12, color: Color(0XFF6B7280)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        (dropDownLoginField == "Phone")
                            ? Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1, color: Color(0XFFE5E7EB))),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _onPressedShowBottomSheet();
                                      },
                                      child: Container(
                                        // color: Colors.red,
                                        height: 45,
                                        width: 130,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 44,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(3)),
                                                  child: (_selectedCountryFlag
                                                          .isEmpty)
                                                      ? Image.asset(
                                                          initialCountry!.flag,
                                                          fit: BoxFit.cover,
                                                          package:
                                                              countryCodePackageName,
                                                          // scale: 5.5,
                                                        )
                                                      : Image.asset(
                                                          _selectedCountryFlag,
                                                          fit: BoxFit.cover,
                                                          package:
                                                              countryCodePackageName,
                                                          // scale: 5.5,
                                                        ),
                                                ),
                                              ),
                                              Icon(Icons.arrow_drop_down),
                                              Text((countryCallingCode.isEmpty)
                                                  ? initialCountry!.callingCode
                                                  : countryCallingCode),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(),
                                    Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 40,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 3),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                controller: phoneController,
                                                onChanged: (value) {
                                                  setState(() {});

                                                  ///////////// Number gets saved in a state management variable that is being updated
                                                  /// anytime the textfield is updated
                                                },
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    border: InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    hintText: 'Phone Number',
                                                    hintStyle:
                                                        GoogleFonts.inter(
                                                            color: Colors
                                                                .black26)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1, color: Color(0XFFE5E7EB))),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  focusNode: textNode,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide
                                            .none, // Remove the border when focused
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide
                                            .none, // Remove the border when enabled
                                      ),
                                      hintText: "Email Address",
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

                InkWell(
                  onTap: () {
                    /////////////////// Checks if the controllers are not empty before activating the button
                    if (phoneController.text.isNotEmpty ||
                        emailController.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });

                      String phone =
                          formatPhone(phone: phoneController.text.trim());
                      // makes the request here
                      forgetPassword(
                        email: emailController.text.isEmpty
                            ? phoneController.text
                            : emailController.text,
                      ).then((value) {
                        if (value["status"] == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ForgotPassword(email: emailController.text.isEmpty
                            ? phoneController.text
                            : emailController.text,)),
                         
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
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 50,
                    decoration: BoxDecoration(
                        color: (phoneController!.text.isEmpty &&
                                emailController.text.isEmpty)
                            ? Color(0XFFF3F4F6)
                            : constants.appMainColor,
                        borderRadius: BorderRadius.circular(200)),
                    child: Center(
                      child: (isLoading)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Continue",
                              style: GoogleFonts.inter(
                                  color: (phoneController!.text.isEmpty &&
                                          emailController.text.isEmpty)
                                      ? const Color(0XFF6B7280)
                                      : Colors.white,
                                  fontSize: 14),
                            ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
    );
  }

  Future<void> authenticate({required provider}) async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: "Scan your finger to authenticate",
          options:
              AuthenticationOptions(useErrorDialogs: true, stickyAuth: false));
    } on PlatformException catch (e) {
      setState(() {
        // here, we add what the app will do when user authenticates
        authorized =
            authenticated ? "Authorized Success" : "Failed to authenticate";
        authorized = e.message!;
      });
    }
    if (!mounted) return;
    setState(() {
      // here, we add what the app will do when user authenticates
      authorized =
          authenticated ? "Authorized Success" : "Failed to authenticate";

      if (authenticated) {
        // if logged in, it sends the app straight to homepage in bottom bar
        if (provider.userType == "serviceProvider") {
          setState(() {
            isLoading = true;
          });

          String spPhone =
              formatPhone(phone: getX.read(constants.GETX_SP_PHONE));
          String spPassword =
              decryptPassword(getX.read(constants.GETX_SP_PASSWORD));
          // mywidgets.displayToast(msg:"The phone passed into it is $spPhone, password is $spPassword");
          // makes the request here
          loginServiceProvider(phoneNumber: spPhone, password: spPassword)
              .then((value) {
            if (value["status"] == true &&
                value["message"] == "login successful") {
              provider.set_sp_login_info(
                  value: value,
                  firstName: value["user_object"]["personal_information"]
                      ["first_name"],
                  lastName: value["user_object"]["personal_information"]
                      ["last_name"],
                  email: value["user_object"]["personal_information"]["email"],
                  id: value["user_object"]["personal_information"]["id"]
                      .toString(),
                  access_token: value["access_token"],
                  profile_image:
                      (value["user_object"]["address_information"] != null)
                          ? value["user_object"]["address_information"]
                              ["profile_image"]
                          : "");
              provider.set_sp_phone(
                  service_provider_phone: value["user_object"]
                      ["personal_information"]["phone"]);
              getX.write(constants.GETX_TOKEN, value["access_token"]);

              ///////////////////// adjusting this place just to make it false so that I can work on this endpoint
              if (value["user_object"]["address_information"] != null ||
                  value["user_object"]["service_information"].isNotEmpty) {
                getX.write(constants.GETX_LOGGED_IN, true);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Bottombar(
                          userType: provider.userType,
                          user_id: (provider.userType == "serviceProvider")
                              ? provider.sp_user_id
                              : provider.client_user_id)),
                  (route) => false,
                );
              } else {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Address_Info()));
              }

              // encrypt the password and save it in the user's device offline, so I can retrieve it later
              // String encryptedPassword=  encryptPassword(passwordController.text.trim());
              // getX.write(constants.GETX_SP_PASSWORD ,encryptedPassword);
              // getX.write(constants.GETX_SP_PHONE, _textEditingController.text.trim(),);
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

        // the account is that of a client
        else {
          setState(() {
            isLoading = true;
          });

          String clientEmail = getX.read(constants.GETX_CLIENT_EMAIL);
          String clientPassword =
              decryptPassword(getX.read(constants.GETX_CLIENT_PASSWORD));

          // mywidgets.displayToast(msg:"The email passed into it is $clientEmail, password is $clientPassword");
          // makes the request here
          loginClient(email: clientEmail, password: clientPassword)
              .then((value) {
            if (value["status"] == true &&
                value["message"] == "login successful") {
              provider.set_client_login_info(
                  value: value,
                  firstName: value["user_object"]["personal_information"]
                      ["first_name"],
                  lastName: value["user_object"]["personal_information"]
                      ["last_name"],
                  email: value["user_object"]["personal_information"]["email"],
                  id: value["user_object"]["personal_information"]["id"]
                      .toString(),
                  access_token: value["access_token"],
                  profile_image:
                      (value["user_object"]["address_information"] != null)
                          ? value["user_object"]["address_information"]
                              ["profile_image"]
                          : "");
              getX.write(constants.GETX_TOKEN, value["access_token"]);
              // provider.set_client_user_id(userId: value["user_object"]["personal_information"]["id"].toString());
              if (value["user_object"]["address_information"] != null ||
                  value["user_object"]["service_information"].isNotEmpty) {
                getX.write(constants.GETX_LOGGED_IN, true);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Bottombar(
                          userType: provider.userType,
                          user_id: (provider.userType == "serviceProvider")
                              ? provider.sp_user_id
                              : provider.client_user_id)),
                  (route) => false,
                );
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ClientAddressInfo()));
              }
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

        // getX.write(constants.GETX_USER_TIER ,provider.userType);
      }
    });
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

  _getDefaultFlag() async {
    setState(() {
      isPageLoading = true;
    });

    final country = await getDefaultCountry(context);
    setState(() {
      initialCountry = country;
      countryCallingCode = country.callingCode;
      _selectedCountryFlag = country.flag;
      isPageLoading = false;
    });
  }

// String formatPhone({required String phone}){
//   if(phone.startsWith("+234")){
//     return phone;
//   }
//   else{
//     String newPhone = phone.substring(1);
//     return "+234$newPhone";
//   }
// }

  _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        // Provider.of<AppData>(context).setCountryCode(country.callingCode);
        countryCallingCode = country.callingCode;
        _selectedCountryFlag = country.flag;
      });
    }
  }

  String formatPhone({required String phone}) {
    if (phone.startsWith("0")) {
      String newPhone = phone.substring(1);
      return "$newPhone";
    } else {
      return phone;
    }
  }
}
