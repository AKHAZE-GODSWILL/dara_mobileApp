import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AddFingerPrint extends StatefulWidget {
 const AddFingerPrint({Key? key}): super(key: key);

 @override
 State<AddFingerPrint> createState() => _AddFingerPrintState();
}

class _AddFingerPrintState extends State<AddFingerPrint>{

LocalAuthentication auth = LocalAuthentication();
bool? _canCheckBiometric; 
List<BiometricType>? _availaleBiometrics;
bool isLoading = false;
String authorized = "Not authorized";

Future<void> checkBiometric() async{
  bool? canCheckBiometric;
  try{
    canCheckBiometric = await auth.canCheckBiometrics;
  } on PlatformException catch(e){
    print(e);
  }
  if(!mounted) return;
  setState(() {
    _canCheckBiometric = canCheckBiometric;
  });
}

Future<void> getAvailableBiometric() async{
  List<BiometricType>? availaleBiometrics; 
  try{
    availaleBiometrics = await auth.getAvailableBiometrics();
  } on PlatformException catch(e){
    print(e);
  }

  setState(() {
    _availaleBiometrics = availaleBiometrics;
  });
}



Future<void> authenticate() async{
  bool authenticated = false;
  try{
    authenticated = await auth.authenticate(
      localizedReason: "Scan your finger to authenticate",
      options: AuthenticationOptions(
        useErrorDialogs: true,
        stickyAuth: false
      )
    );
  } on PlatformException catch(e){
    
      print(e);
      setState(() {
    // here, we add what the app will do when user authenticates
    authorized = authenticated? "Authorized Success": "Failed to authenticate";
    authorized = e.message!;
    print(authorized); 
  });
      
  }
  if(!mounted) return;
  setState(() {
    // here, we add what the app will do when user authenticates
    authorized = authenticated? "Authorized Success": "Failed to authenticate";
    authenticated? CustomSuccessDialog():();
    print(authorized); 
  });
}

  @override
  void initState() {
    print("The init state");
    checkBiometric();
    getAvailableBiometric();
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
                      child: Text("Set Up FingerPrint",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 10,),

                    

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Container(
                        height: 64,
                        width: 304,
                        child: Text("Enhance the security and personalization of your account by adding a fingerprint",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    SizedBox(height: 50,),

                    Container(
                      // color: Colors.red,
                      width: 108,
                      height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/fingerPrint.png"),
                        fit: BoxFit.fill)
                        ,
                      ),
                    ),

                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Container(
                        width: 272,
                        child: Text("To add your fingerprint, gently lift and place your finger on the home button",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 50,),

            InkWell(
                      onTap: (){
                        /////////////////// Push to the next page after user has selected a tier
                        
                        // if(_textEditingController!.text.isNotEmpty){
                        //   ///// Navigation.push to the OTP screen
                          
                        // }
                        authenticate();
                        // CustomSuccessButton();

                        //will save this parameter to state management later
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.85,
                        height: 50,
                        decoration: BoxDecoration(
                          // color: (_textEditingController!.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                          color: constants.appMainColor,
                          borderRadius: BorderRadius.circular(200)
                        ),
                        child: Center(
                          child: Text(
                            "Enable Fingerprint",
                            style: TextStyle(
                              // color: (_textEditingController!.text.isEmpty)? Color(0XFF6B7280):Colors.white,
                              color: Colors.white,
                              fontSize: 14),),
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login())
                          );
                        },
                        child: Container(
                          width: 100,
                          child: Center(
                            child: Text('Maybe Later',
                            style: TextStyle(color: constants.appMainColor),),
                          )),
                      ),

     
          ],
      
        ),
      )
    );
  }

  CustomSuccessDialog(){
    return showDialog(
      barrierColor: Color(0XFF121212).withOpacity(0.7),
      context: context,
      builder: (context){
        return StatefulBuilder(builder: (context, setState){
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width*0.9,
                  // height: 338,
                  // width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Container(
                        height: 105,
                        width: 105,
                        decoration: BoxDecoration(
                          color: Color(0XFF22C55E),
                          shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check, 
                            color: Colors.white,
                            size: 80,
                            ),
                        ),
                      ),
                      Text("Congratulations",
                          style: TextStyle(fontSize: 20,
                            color: Colors.black,
                            decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center,
                          ),
                      
                      Text("Your service provider account was created successfully",
                          style: TextStyle(fontSize: 14,
                            color: Colors.black,
                            decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center,
                          ),
                      
                      Container(
                        child: GestureDetector(

                          onTap: (){
                            /////////////////// Push to the next page after user has selected a tier
                            
                            // if(_textEditingController!.text.isNotEmpty){
                            //   ///// Navigation.push to the OTP screen
                              
                            // }
                            Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login())
                          );
                            
                            //will save this parameter to state management later
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.85,
                            height: 50,
                            decoration: BoxDecoration(
                              // color: (_textEditingController!.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                              color: constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  // color: (_textEditingController!.text.isEmpty)? Color(0XFF6B7280):Colors.white,
                                  color: Colors.white,
                                  fontSize: 14,
                                  decoration: TextDecoration.none),),
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
      }
    );
  }
}

