import 'package:dara_app/main.dart';
import 'package:dara_app/screens/onboarding/onBoard1.dart';
import 'package:dara_app/screens/onboarding/onBoard2.dart';
import 'package:dara_app/screens/onboarding/onBoard3.dart';
import 'package:dara_app/screens/onboarding/onBoard4.dart';
import 'package:dara_app/screens/authentication/selectTier.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainOnboard extends StatefulWidget {
 const MainOnboard({Key? key}): super(key: key);

 @override
 State<MainOnboard> createState() => _MainOnboardState();
}

class _MainOnboardState extends State<MainOnboard>{

  // List<Widget> screens =<Widget>[];
  PageController? _controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose(){
    _controller!.dispose();
    super.dispose();
  }

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.08,),

          Expanded(
            child: PageView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: pageController,
              onPageChanged: (index){
                setState((){
                  currentIndex = index;
                  print(currentIndex);
                });
              },
              children: [
                Onboard1(),
                Onboard2(),
                Onboard3(),
                Onboard4()
              ],
            ),
          ),

          SizedBox(height: 30,),

          ///////////// The animated dots goes in here
          
          buildIndicator(),

          //////////// the first button goes in here 
          
          SizedBox(height: MediaQuery.of(context).size.height*0.13,),

          InkWell(
            onTap: (){
              ///// The next function goes in here to animate  the page view
              nextSlide();
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
                 (currentIndex <3)? "Next": "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14),),
              ),
            ),
          ),



          ///////// The skip button goes in here
          
          SizedBox(height: 30,),

          (currentIndex <3)? InkWell(
            onTap: (){
              ///// The next function goes in here to animate  the page view
              Navigator.push(context,MaterialPageRoute(
                      builder: (context)=> SelectTier()
                    ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.4,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200)
              ),
              child: Center(
                child: Text("Skip", 
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14),),
              ),
            ),
          ): SizedBox(),

          SizedBox(height: 10,)


        ],
      )
    );
  }

 void nextSlide(){
    if(currentIndex <3){
      print("Current inde is $currentIndex and the next index is ");

      pageController.animateToPage(
        ++currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    }
    else{

      print("Currentl at last slide");
      Navigator.push(context,MaterialPageRoute(
                      builder: (context)=> SelectTier()
      ));
    }
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        
        activeIndex: currentIndex,
        count: 4,
        effect: WormEffect(
          dotWidth: 10,
          dotHeight:10,
          activeDotColor: constants.appMainColor,
          dotColor: Colors.grey
        ),

  );

}