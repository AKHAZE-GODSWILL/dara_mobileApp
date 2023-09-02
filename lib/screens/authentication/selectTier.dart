import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/registration.dart';
import 'package:flutter/material.dart';

class SelectTier extends StatefulWidget {
 const SelectTier({Key? key}): super(key: key);

 @override
 State<SelectTier> createState() => _SelectTierState();
}

class _SelectTierState extends State<SelectTier>{

  String selectedTier ="";


  @override
  void initState() {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // First section
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
                      child: Text("Why are you here",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10),
                      child: Text("Please select whether you are seeking a project to work on or you are a client in search of an expert to work for you",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                      ),
                    )
                ],
              ),
            ),

            // second section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [

                  /////////////// First row in the middle
                  InkWell(
                    onTap: (){
                      /////////////////
                      ///
                      ///
                      ///
                      ///
                      setState(() {
                        selectedTier = "serviceProvider";
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: (selectedTier == "serviceProvider")? Border.all(
                          color: constants.appMainColor,
                          width: 2
                        ): Border.all(
                          color: constants.appMainColor.withOpacity(0.1),
                          width: 2
                        )
                      ),
                      child: Row(
                        children: [
                          SizedBox(height: 20,),
                        
                      Container(
                        // color: Colors.red,
                        width: 64,
                        height: 64,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/serviceProviderLogo.png"),
                          fit: BoxFit.cover)
                          ,
                        ),
                      ),
                  
                      SizedBox(height: 20,),
                  
                      Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10),
                              child: Text("Service Provider",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                              ),
                            ),
                  
                            SizedBox(height: 10,),
                  
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10),
                              child: Text("Seeking projects to work on and clients to work with",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      )
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 30,),
                  /////////// Second row in the middle
                  
                  InkWell(
                    onTap: (){
                      /////////////////
                      ///
                      ///
                      ///
                      ///
                      setState(() {
                        selectedTier = "client";
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: (selectedTier == "client")? Border.all(
                          color: constants.appMainColor,
                          width: 2
                        ): Border.all(
                          color: constants.appMainColor.withOpacity(0.1),
                          width: 2
                        )
                      ),
                      child: Row(
                        children: [
                          SizedBox(height: 20,),
                        
                      Container(
                        // color: Colors.red,
                        width: 64,
                        height: 64,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/clientLogo.png"),
                          fit: BoxFit.cover)
                          ,
                        ),
                      ),
                  
                      SizedBox(height: 20,),
                  
                      Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10),
                              child: Text("Client",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                              ),
                            ),
                  
                            SizedBox(height: 10,),
                  
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10),
                              child: Text("Searching for experts to work for you on a project",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Third section
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20,),
      
                    InkWell(
                      onTap: (){
                        /////////////////// Push to the next page after user has selected a tier
                        
                        if(selectedTier.isEmpty){
                          mywidgets.displayToast(msg: "Please select a tier");
                        }
                        else{
                          ///// Navigation.push
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Registration()),
                            (route) => false,
                          );
                        }

                        //will save this parameter to state management later
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
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14),),
                        ),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.1),
                ],
              ),
            )
          ],
      
        ),
      )
    );
  }


}

