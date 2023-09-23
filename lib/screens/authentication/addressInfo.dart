import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/registration.dart';
import 'package:dara_app/screens/authentication/serviceInfo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Address_Info extends StatefulWidget{
  Address_Info({Key? key}): super(key: key);

  @override
  State<Address_Info> createState() => _Address_Info();
}

class _Address_Info extends State<Address_Info>{

  final specificAddressController = TextEditingController();

  String? dropdownvalueCountry;
  String? dropdownvalueState;
  String? dropdownvalueLGA;
  var country = [
    'Nigeria',
    "Ghana",
    "South Africa",
    "USA",
    "Other Countries would be gotten from Api",
  ];

  var state = [
    'Lagos',
    "Cairo",
    "Kampala",
    "Texas",
    "Other States would be gotten from Api",
  ];

  var localGovernmentArea = [
    'Egor',
    "Surulere",
    "Uselu",
    "Mushin",
    "Other Local Government Areas would be gotten from Api",
  ];


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

    specificAddressController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Information", 
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: 20,),
              Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10),
                        child: CircularPercentIndicator(
                                      radius: 50.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      lineWidth: 7.0,
                                      percent: 0.3,
                                      center: new Text(
                                        "30%",
                                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      backgroundColor: Color(0XFFF3F4F6),
                                      progressColor: constants.appMainColor,
                                    ),
                      ),
                      Container(
                        // color: Colors.red,
                        height: 92,
                        width: 234,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [  
                              Text("You're Almost Done",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                              ),
                                    
                                    
                              SizedBox(height: 10,),
                                    
                              Text("Maximize your experience as a service provide with Dara by connecting with clients. Complete these steps to make the most out of the platform",
                              style: TextStyle(
                                fontSize: 12,),
                              ),
                                    
                              SizedBox(height: 10,),
                                    
                              
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              

                SizedBox(height: 20,),

                // Country
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Country", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width*0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black38,
                            ),
                            hint: Text(
                              'Select Your Country',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            items: country
                                .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style:  TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: dropdownvalueCountry,
                            onChanged: (value) {
                              setState(() {
                                dropdownvalueCountry = value as String;
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
              
              SizedBox(height: 20,),
              
              // State
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("State", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width*0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black38,
                            ),
                            hint: Text(
                              'Select Your State',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            items: state
                                .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style:  TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: dropdownvalueState,
                            onChanged: (value) {
                              setState(() {
                                dropdownvalueState = value as String;
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
              
              SizedBox(height: 20,),
              
              //Area
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Area(L.G.A)", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,),
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width*0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Color(0XFFE5E7EB)
                          )
                        ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black38,
                            ),
                            hint: Text(
                              'Select Your Local Government Area',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            items: state
                                .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style:  TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: dropdownvalueLGA,
                            onChanged: (value) {
                              setState(() {
                                dropdownvalueLGA = value as String;
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
              
              SizedBox(height: 20,),

              //Specific Address
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Specific Address", style: TextStyle(fontSize: 12),),
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
                          controller: specificAddressController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Enter your specific location address",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 30,),
              
                        InkWell(
                          onTap: (){
                            /////////////////// Push to the next page after user has selected a tier
                            
                            if(
                            dropdownvalueCountry != null
                              &&  dropdownvalueState != null
                              && dropdownvalueLGA != null 
                              && specificAddressController.text.isNotEmpty){
                              ///// Navigation.push to the OTP screen
                               Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Service_Info())
                              );                            }
                            /// Navigation.push to the OTP screen
                             
                            //will save this parameter to state management later
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.85,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (
                                 dropdownvalueCountry == null 
                                || dropdownvalueState == null
                                || dropdownvalueLGA == null 
                                ||  specificAddressController.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: (
                                    dropdownvalueCountry == null 
                                || dropdownvalueState == null
                                || dropdownvalueLGA == null 
                                ||  specificAddressController.text.isEmpty
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
}