import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/login.dart';
import 'package:dara_app/screens/authentication/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:flutter/gestures.dart';

import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';

class Registration extends StatefulWidget {
 const Registration({Key? key}): super(key: key);

 @override
 State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>{

Country? initialCountry;
TextEditingController? _textEditingController;
String _selectedCountryFlag = "";
String countryCallingCode = "";
bool isLoading = false;


  @override
  void initState() {
    _getDefaultFlag();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: (isLoading)? Center(
          child:CircularProgressIndicator(color: constants.appMainColor)):Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: Text("Registration",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Text("Provide your mobile phone number so that we can send you an OTP for verification",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                      ),
                    )
                ],
              ),
            ),

            SizedBox(height: 50,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
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
                                        controller: _textEditingController,
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
                                          hintStyle:  TextStyle(color: Colors.black26)
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
            ),

                    SizedBox(height: 50,),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'By creating an account, you agree to our ',
                              
                            ),
                            
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                color: constants.appMainColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the tap gesture for 'World!'
                                  print('Terms and conditions tapped');
                                }
                            ),
                            TextSpan(
                              text: ' and ',
                            ),
                    
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: constants.appMainColor
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the tap gesture for 'World!'
                                  print('Privacy Policy ckicked');
                                }
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    InkWell(
                      onTap: (){
                        /////////////////// Push to the next page after user has selected a tier
                        
                        if(_textEditingController!.text.isNotEmpty){
                          ///// Navigation.push to the OTP screen
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => OtpVerification())
                          );
                        }

                        //will save this parameter to state management later
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.85,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (_textEditingController!.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                          borderRadius: BorderRadius.circular(200)
                        ),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              color: (_textEditingController!.text.isEmpty)? Color(0XFF6B7280):Colors.white,
                              fontSize: 14),),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Already a user? ',
                              
                            ),
                            
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: constants.appMainColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the tap gesture for 'World!'

                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => Login())
                                  );
                                  print('Terms and conditions tapped');
                                }
                            ),
                          ],
                        ),
                      ),
                    ),

     
          ],
      
        ),
      )
    );
  }

  _getDefaultFlag() async{

    setState(() {
      isLoading = true;
    });

    final country = await getDefaultCountry(context);
    setState(() {
      initialCountry = country;
      isLoading = false;
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


}

