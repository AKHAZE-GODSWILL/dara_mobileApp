import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/addFingerPrint.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class Personal_Info extends StatefulWidget{
  Personal_Info({Key? key}): super(key: key);

  @override
  State<Personal_Info> createState() => _Personal_Info();
}

class _Personal_Info extends State<Personal_Info>{

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referralCodeController = TextEditingController();

  bool isLoading = false;
  final textNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  Country? initialCountry;
  String _selectedCountryFlag = "";
  String countryCallingCode = "";
  bool isPageLoading = false;
  
  bool isPasswordObscured = false;
  bool isConfirmPasswordObscured = false;

  @override
  void initState() {
    // TODO: implement initState
    _getDefaultFlag();
    isPasswordObscured = true;
    isConfirmPasswordObscured = true;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    firstNameController.dispose();
    lastNameController.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    referralCodeController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child:(isPageLoading)? Center(child: CircularProgressIndicator(),) :Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: Column(
                    
                    children: [
                        SizedBox(height: MediaQuery.of(context).size.width*0.15,),
          
                        Container(
                          // color: Colors.red,
                          width: MediaQuery.of(context).size.width*0.3,
                          height: MediaQuery.of(context).size.width*0.1,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/daraLogo.png"),
                            fit: BoxFit.cover)
                            ,
                          ),
                        ),
              
                        SizedBox(height: 20,),
              
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10),
                          child: Text("Personal Information",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                          ),
                        ),
              
                        SizedBox(height: 10,),
              
                        
                    ],
                  ),
                ),
              
                // First Name
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First Name", style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0XFF6B7280)),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                        child: TextFormField(
                          // focusNode: textNode,
                          onChanged: (value){
                        setState(() {
                          
                        });
                      },
                          keyboardType: TextInputType.emailAddress,
                          controller: firstNameController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Enter your first name",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0XFF6B7280)
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),
              
              // last name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Last Name", style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0XFF6B7280)),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                        child: TextFormField(
                          // focusNode: textNode,
                          onChanged: (value){
                        setState(() {
                          
                        });
                      },
                          keyboardType: TextInputType.emailAddress,
                          controller: lastNameController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Enter your last name",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0XFF6B7280)
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),
              
              //Email
              (provider.userType == "serviceProvider")? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email Address", style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0XFF6B7280)),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                        child: TextFormField(
                          // focusNode: textNode,
                          onChanged: (value){
                        setState(() {
                          
                        });
                      },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailAddressController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Enter your email Address",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0XFF6B7280)
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ) 
              
              :Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Phone Number", style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Color(0XFF6B7280)),),
                    SizedBox(height: 5,),
                    Container(
                      height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                      child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      _onPressedShowBottomSheet();
                                    },
                                    child: Container(
                                      // color: Colors.red,
                                      height: 45,
                                      width: 130,
                                      child:  Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 44,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                                child: (_selectedCountryFlag.isEmpty)? Image.asset(
                                                  initialCountry!.flag,
                                                  fit: BoxFit.cover,
                                                  package: countryCodePackageName,
                                                  // scale: 5.5,
                                                ) :Image.asset(
                                                  _selectedCountryFlag,
                                                  fit: BoxFit.cover,
                                                  package: countryCodePackageName,
                                                  // scale: 5.5,
                                                ),
                                              ),
                                            ),
                                            Icon(Icons.arrow_drop_down),
              
                                       Text((countryCallingCode.isEmpty)? initialCountry!.callingCode: countryCallingCode),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(),
                                  Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width*0.4,
                                    child:  Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.4,
                                          height: 40,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 3),
                                            child: TextFormField(
                                              keyboardType: TextInputType.phone,
                                              controller: phoneController,
                                              onChanged: (value){
              
                                                setState(() {
              
                                                });
              
                                                ///////////// Number gets saved in a state management variable that is being updated
                                                /// anytime the textfield is updated
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder: InputBorder.none,
                                                border: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                                hintText: 'Phone Number',
                                                hintStyle:  GoogleFonts.inter(color: Colors.black26)
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
              
                                ],
                              ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20,),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Password", style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0XFF6B7280)),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                        child: TextFormField(
                          onChanged: (value){
                        setState(() {
                          
                        });
                      },
                          obscureText: isPasswordObscured,
                          focusNode: passwordFocusNode,
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Create Password",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0XFF6B7280)
                            ),
                            suffixIcon: IconButton(
                              padding: EdgeInsetsDirectional.only(end:12),
                              icon: isPasswordObscured? Icon(Icons.visibility): Icon(Icons.visibility_off),
                              onPressed: (){
                                setState(() {
                                  isPasswordObscured = !isPasswordObscured;
                                });
                              }
                            ),
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              passwordFocusNode.requestFocus();
                              return "Please enter some text";
                            }
                            if(value.length <6){
                              passwordFocusNode.requestFocus();
                              return "Password must be atleast 6 characters";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Password must contain at least 8 characters",
                   style: GoogleFonts.inter(
                    fontSize: 12, color: Color(0XFF9CA3AF)),),
                ),
              ),
              
              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Confirm Password (password must match)", style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0XFF6B7280)),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                        child: TextFormField(
                          onChanged: (value){
                        setState(() {
                          
                        });
                      },
                          obscureText: isConfirmPasswordObscured,
                          focusNode: confirmPasswordFocusNode,
                          keyboardType: TextInputType.text,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Confirm Password",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0XFF6B7280)
                            ),
                            suffixIcon: IconButton(
                              padding: EdgeInsetsDirectional.only(end:12),
                              icon: isConfirmPasswordObscured? Icon(Icons.visibility): Icon(Icons.visibility_off),
                              onPressed: (){
                                setState(() {
                                  isConfirmPasswordObscured = !isConfirmPasswordObscured;
                                });
                              }
                            ),
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              confirmPasswordFocusNode.requestFocus();
                              return "Please enter some text";
                            }
                            if(value.length <6){
                              confirmPasswordFocusNode.requestFocus();
                              return "Password must be atleast 6 characters";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Referral Code (Optional)", style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0XFF6B7280)),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                        child: TextFormField(
                          // focusNode: textNode,
                          onChanged: (value){
                        setState(() {
                          
                        });
                      },
                          keyboardType: TextInputType.emailAddress,
                          controller: referralCodeController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Enter referral code if you have one",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0XFF6B7280)
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 40,),
              
                     (provider.userType == "serviceProvider")?   InkWell(
                          onTap: (){
                            /////////////////// Push to the next page after user has selected a tier
                            
                            if(
                              firstNameController!.text.isNotEmpty
                              && lastNameController.text.isNotEmpty
                              && emailAddressController.text.isNotEmpty 
                              && passwordController.text.isNotEmpty
                              && confirmPasswordController.text.isNotEmpty
                              ){

                                if(confirmPasswordController.text.trim() != passwordController.text.trim()){
                                  Fluttertoast.showToast(msg: "password must match");
                                }
                                else{

                                  setState(() {
                                    isLoading = true;
                                  });
                          

                                  // makes the request here
                                    serviceProviderPersonalInfo(
                                      phoneNumber: "${provider.sp_countryCallCode}${provider.serviceProviderPhone}" ,
                                      firstName: firstNameController.text.trim(),
                                      lastName: lastNameController.text.trim(),
                                      email: emailAddressController.text.trim(),
                                      password: passwordController.text.trim()
                                     ).then((value) {

                                    print("The final Value of what was resulted from the request was :$value");

                                    if(value["status"]== true){
                                      ///// Navigation.push to the OTP screen
                                      provider.set_sp_personal_info(
                                        firstName: firstNameController.text.trim(),
                                        lastName: lastNameController.text.trim(),
                                        email: emailAddressController.text.trim()
                                      );
                                      /// Navigation.push to the OTP screen
                                      Navigator.of(context).push(
                                        // MaterialPageRoute(builder: (context) => Authenticate())
                                        MaterialPageRoute(builder: (context) => AddFingerPrint())
                                      );

                                      // encrypt the password and save it in the user's device offline, so I can retrieve it later
                              String encryptedPassword=  encryptPassword(passwordController.text.trim());
                              getX.write(constants.GETX_SP_PASSWORD ,encryptedPassword);
                              getX.write(constants.GETX_SP_PHONE, "${provider.sp_countryCallCode}${provider.serviceProviderPhone}");
                                    }
                                    else if(value["status"] == "Network Error"){
                                      mywidgets.displayToast(msg: "Network Error. Check your Network Connection and try again");
                                    }
                                    else{
                                      mywidgets.displayToast(msg: value["message"]);
                                    }

                                    setState(() {
                                      isLoading = false;
                                    });
                                  });

                                  
                                }
                              
                            }
              
                            //will save this parameter to state management later
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.85,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (
                                firstNameController!.text.isEmpty 
                                || lastNameController.text.isEmpty
                                || emailAddressController.text.isEmpty
                                || passwordController.text.isEmpty
                                || confirmPasswordController.text.isEmpty
                                )? Color(0XFFF3F4F6): constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: (isLoading)? CircularProgressIndicator(color: Colors.white,) 
                                :Text(
                                "Submit",
                                style: GoogleFonts.inter(
                                  color: (firstNameController!.text.isEmpty 
                                || lastNameController.text.isEmpty
                                || emailAddressController.text.isEmpty
                                || passwordController.text.isEmpty
                                || confirmPasswordController.text.isEmpty
                                )? Color(0XFF6B7280):Colors.white,
                                  fontSize: 14),),
                            ),
                          ),
                        )
                        :InkWell(
                          onTap: (){
                            /////////////////// Push to the next page after user has selected a tier
                            
                            if(
                              firstNameController!.text.isNotEmpty
                              && lastNameController.text.isNotEmpty
                              && phoneController.text.isNotEmpty 
                              && passwordController.text.isNotEmpty
                              && confirmPasswordController.text.isNotEmpty
                              ){

                                if(confirmPasswordController.text.trim() != passwordController.text.trim()){
                                  Fluttertoast.showToast(msg: "password must match");
                                }
                              /// Navigation.push to the OTP screen 
                              
                              else{
                                setState(() {
                                    isLoading = true;
                                  });
                          
                                  String phone  = formatPhone(phone: phoneController.text.trim());
                                  // makes the request here
                                    clientPersonalInfo(
                                      email: provider.client_email,
                                      firstName: firstNameController.text.trim(),
                                      lastName: lastNameController.text.trim(),
                                      phone: "${countryCallingCode}${phone}",
                                      password: passwordController.text.trim()
                                     ).then((value) {

                                    print("The final Value of what was resulted from the request was :$value");

                                    if(value["status"]== true){
                                      ///// Navigation.push to the OTP screen 
                                      provider.set_client_user_id(userId: value["data"]["user_id"].toString());
                                      provider.set_client_personal_info(
                                        firstName: firstNameController.text.trim(),
                                        lastName: lastNameController.text.trim(),
                                        email: emailAddressController.text.trim(),
                                        phone: "${countryCallingCode}${phone}"
                                      );
                                      Navigator.of(context).push(
                                        // MaterialPageRoute(builder: (context) => Authenticate())
                                        MaterialPageRoute(builder: (context) => AddFingerPrint())
                                      );

                                      // encrypt the password and save it in the user's device offline, so I can retrieve it later
                                      String encryptedPassword=  encryptPassword(passwordController.text.trim());
                                      getX.write(constants.GETX_CLIENT_PASSWORD ,encryptedPassword);
                                      getX.write(constants.GETX_CLIENT_EMAIL, provider.client_email,);
                                    }
                                    else if(value["status"] == "Network Error"){
                                      mywidgets.displayToast(msg: "Network Error. Check your Network Connection and try again");
                                    }
                                    else{
                                      mywidgets.displayToast(msg: value["message"]);
                                    }

                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                
                              }
                            }
              
                            //will save this parameter to state management later
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.85,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (
                                firstNameController!.text.isEmpty 
                                || lastNameController.text.isEmpty
                                || phoneController.text.isEmpty
                                || passwordController.text.isEmpty
                                || confirmPasswordController.text.isEmpty
                                )? Color(0XFFF3F4F6): constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child:(isLoading)? CircularProgressIndicator(color: Colors.white,) 
                              :Text(
                                "Submit",
                                style: GoogleFonts.inter(
                                  color: (firstNameController!.text.isEmpty 
                                || lastNameController.text.isEmpty
                                || phoneController.text.isEmpty
                                || passwordController.text.isEmpty
                                || confirmPasswordController.text.isEmpty
                                )? Color(0XFF6B7280):Colors.white,
                                  fontSize: 14),),
                            ),
                          ),
                        ),
              
              // Padding(padding: )
            ],
          ),
        ),
      ),
    );
  }

  String encryptPassword(String password) {
  // Generate a random IV for encryption
  final iv = encrypt.IV.fromSecureRandom(16);

  final privateKey = encrypt.Key(Uint8List.fromList(utf8.encode(constants.encryptionKey)));
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
  final privateKey = encrypt.Key(Uint8List.fromList(utf8.encode(constants.encryptionKey)));
  final encryptedDataMap = jsonDecode(encryptedData);

  final ivBytes = base64Decode(encryptedDataMap['iv']);
  final iv = encrypt.IV(Uint8List.fromList(ivBytes));

  final encrypter = encrypt.Encrypter(encrypt.AES(privateKey));
  final encryptedPassword = encrypt.Encrypted.fromBase64(encryptedDataMap['password']);

  // Decrypt and return the password
  return encrypter.decrypt(encryptedPassword, iv: iv);
}

_getDefaultFlag() async{

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

  _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {

      setState(() {
        // Provider.of<AppData>(context).setCountryCode(country.callingCode);
        countryCallingCode = country.callingCode;
        _selectedCountryFlag  = country.flag;
      });
    }
  }

  String formatPhone({required String phone}){
  
  if(phone.startsWith("0")){
    String newPhone = phone.substring(1);
    return "$newPhone";
  }

  else{
    return phone;
  }
}
}