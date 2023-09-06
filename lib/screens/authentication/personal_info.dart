import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/registration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Personal_Info extends StatefulWidget{
  Personal_Info({Key? key}): super(key: key);

  @override
  State<Personal_Info> createState() => _Personal_Info();
}

class _Personal_Info extends State<Personal_Info>{

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final referralCodeController = TextEditingController();

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

    firstNameController.dispose();
    lastNameController.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
    referralCodeController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              
                // First Name
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First Name", style: TextStyle(fontSize: 12),),
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
                      Text("Last Name", style: TextStyle(fontSize: 12),),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),
              
              //Email
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email Address", style: TextStyle(fontSize: 12),),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),
              
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
                            hintText: "Create Password",
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Password must contain at least 8 characters", style: TextStyle(fontSize: 12),),
              ),
              
              SizedBox(height: 20,),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Referral Code (Optional)", style: TextStyle(fontSize: 12),),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20,),
              
              SizedBox(height: 20,),
              
                        InkWell(
                          onTap: (){
                            /////////////////// Push to the next page after user has selected a tier
                            
                            if(
                              firstNameController!.text.isNotEmpty
                              && lastNameController.text.isNotEmpty
                              && emailAddressController.text.isNotEmpty 
                              && passwordController.text.isNotEmpty){
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
                              color: (
                                firstNameController!.text.isEmpty 
                                || lastNameController.text.isEmpty
                                || emailAddressController.text.isEmpty
                                || passwordController.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: (firstNameController!.text.isEmpty 
                                || lastNameController.text.isEmpty
                                || emailAddressController.text.isEmpty
                                || passwordController.text.isEmpty)? Color(0XFF6B7280):Colors.white,
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
}