

import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/accountConfirm.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';

class WithdrawalAccount extends StatefulWidget {
  const WithdrawalAccount({Key? key}) : super(key: key);

  @override
  State<WithdrawalAccount> createState() => _WithdrawalAccountState();
}

class _WithdrawalAccountState extends State<WithdrawalAccount> {

  String? dropdownvalueBankName;
  var bankName = [
    'First Bank',
    "UBA",
    "Fidelity",
    "Guaranty Trust Bank",
    "Other Banks would be gotten from Api",
  ];

  String? dropdownvalueSecurityQuestion;
  var securityQuestion = [
    'What is the name of your pet',
    "What is your mother's maiden name",
    "What is your favourite colour",
    "What is the name of your best friend"
  ];
  final securityAnswerController = TextEditingController();
  
  final accountNumberController = TextEditingController();

  @override
void initState() {
super.initState();
}

// @override
// void dispose() {
// super.dispose();
// _controller.dispose();
// }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: false,
        titleSpacing: 0,
        title: Transform(
          transform: Matrix4.translationValues(-55, 0, 0),
          child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border:
                          Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                
                                  onPressed: (){
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
                  padding: const EdgeInsets.only(left:12.0),
                  child: Text(
                    "Withdrawal Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                // Spacer(),
              ],
            ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          
              SizedBox(height: 20,),
        
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: Text("Enter Account Details", 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),
                    ),
                  ),
                  
                  SizedBox(height: 20,),
                          // Bio
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Add your bank account to specify where you would like your withdrawn funds to be deposited.", 
                    style: TextStyle(fontSize: 12,color: Colors.black54),),
                ),
                ],
              ),
              
              SizedBox(height: 20,),
        
              //Account Number
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Account Number", style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12),),
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
                          keyboardType: TextInputType.number,
                          controller: accountNumberController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Enter your account number",
                            hintStyle: TextStyle(
                              color: Colors.black54
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        
              
              (dropdownvalueBankName != null && accountNumberController.text.isNotEmpty)? Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: constants.appMainColor.withOpacity(0.08)
                  ),
                  child:Center(
                    child: Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Daniel Smith", style: TextStyle(
                        color: constants.appMainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ):SizedBox(),
              
              
              SizedBox(height: 20,),
        
                // Country
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bank", style: TextStyle(fontSize: 12),),
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
                              'Select Bank',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            items: bankName
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
                            value: dropdownvalueBankName,
                            onChanged: (value) {
                              setState(() {
                                dropdownvalueBankName = value as String;
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
        
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Security question", style: TextStyle(fontSize: 12),),
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
                              'Select Security Question',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            items: securityQuestion
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
                            value: dropdownvalueSecurityQuestion,
                            onChanged: (value) {
                              setState(() {
                                dropdownvalueSecurityQuestion = value as String;
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
        
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Security answer", style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12),),
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
                          keyboardType: TextInputType.text,
                          controller: securityAnswerController,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border when enabled
                        ),
                            hintText: "Enter Security Answer",
                            hintStyle: TextStyle(
                              color: Colors.black54
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        
              SizedBox(height: 20,),
        
                InkWell(
                          onTap: (){
                            
                            provider.setBankDetails(nameOfBank: dropdownvalueBankName?? "First Bank",
                             accNumber: (accountNumberController.text.isNotEmpty)? accountNumberController.text.trim():"0100000002000");

                            provider.setSecurityDetails(securedQuestion: dropdownvalueSecurityQuestion?? "What is your Mother's Maiden Name",
                             securedAnswer: (securityAnswerController.text.isNotEmpty)? securityAnswerController.text.trim():"Smith");

                            Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return AccountConfirm();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    )
                                  );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.85,
                            height: 50,
                            decoration: BoxDecoration(
                              color: constants.appMainColor,
                              borderRadius: BorderRadius.circular(200)
                            ),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 14),),
                            ),
                          ),
                        ),
        
                        SizedBox(height: 60,),
        
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
                                    }
                                ),
                              ],
                            ),
                          ),
                        ),
        
                        SizedBox(height: 60,),
            
          
          
            ],
          ),
        ),
      )
    );
  }
}
