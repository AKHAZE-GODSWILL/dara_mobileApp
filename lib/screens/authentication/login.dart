import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/registration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  Login({Key? key}): super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login>{

  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  final passwordController = TextEditingController();

  final textNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool isObscured = false;

  @override
  void initState() {
    // TODO: implement initState

    isObscured = true;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _textEditingController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
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
                      child: Text("Login To Your Account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 10,),

                    
                ],
              ),
            ),

            Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login ID", style: TextStyle(fontSize: 12),),
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
                      focusNode: textNode,
                      keyboardType: TextInputType.emailAddress,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide.none, // Remove the border when focused
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none, // Remove the border when enabled
                    ),
                        hintText: "Phone number/Email Address",
                      ),
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
                  Text("Password", style: TextStyle(fontSize: 12),),
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
                      obscureText: isObscured,
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
                        hintText: "Enter Password",
                        suffixIcon: IconButton(
                          padding: EdgeInsetsDirectional.only(end:12),
                          icon: isObscured? Icon(Icons.visibility): Icon(Icons.visibility_off),
                          onPressed: (){
                            setState(() {
                              isObscured = !isObscured;
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
          
          SizedBox(height: 20,),

                    InkWell(
                      onTap: (){
                        /////////////////// Push to the next page after user has selected a tier
                        
                        if(_textEditingController!.text.isNotEmpty && passwordController.text.isNotEmpty){
                          ///// Navigation.push to the OTP screen
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (context) => OtpVerification())
                          // );
                        }

                        //will save this parameter to state management later
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.85,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (_textEditingController!.text.isEmpty || passwordController.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                          borderRadius: BorderRadius.circular(200)
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: (_textEditingController!.text.isEmpty || passwordController.text.isEmpty)? Color(0XFF6B7280):Colors.white,
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
                              text: 'Don\'t have an account? ',
                              
                            ),
                            
                            TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                color: constants.appMainColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the tap gesture for 'World!'

                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => Registration())
                                  );
                                  print('Terms and conditions tapped');
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
          
          // Padding(padding: )
        ],
      ),
    );
  }
}