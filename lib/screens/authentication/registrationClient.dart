import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/login.dart';
import 'package:dara_app/screens/authentication/otpVerification.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:flutter/gestures.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:provider/provider.dart';

class RegistrationClient extends StatefulWidget {
  const RegistrationClient({Key? key}): super(key: key);

  @override
  State<RegistrationClient> createState() => _RegistrationClientState();
}

class _RegistrationClientState extends State<RegistrationClient>{

  Country? initialCountry;
  TextEditingController? emailController;
  bool isLoading = false;


  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
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
                      child: Text("Provide your email so that we can send you an OTP for verification",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 50,),

              // First Name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: TextStyle(fontSize: 12),),
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
                          controller: emailController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide.none, // Remove the border when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none, // Remove the border when enabled
                            ),
                            hintText: "Enter your email address",
                          ),
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

                  if(emailController!.text.isNotEmpty){

                    setState(() {
                            isLoading = true;
                          });
                          

                          // makes the request here
                          registerClient(email: emailController!.text.trim()).then((value) {

                            print("The final Value of what was resulted from the request was :$value");

                            if(value["status"]== true){
                              ///// Navigation.push to the OTP screen
                              provider.set_client_email(clientEmail: emailController!.text.trim());
                              ///// Navigation.push to the OTP screen
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => OtpVerification())
                              );
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

                  //will save this parameter to state management later
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: 50,
                  decoration: BoxDecoration(
                      color: (emailController!.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                      borderRadius: BorderRadius.circular(200)
                  ),
                  child: Center(
                    child:(isLoading)? CircularProgressIndicator(color: Colors.white,) 
                    :Text(
                      "Continue",
                      style: TextStyle(
                          color: (emailController!.text.isEmpty)? Color(0XFF6B7280):Colors.white,
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


}

