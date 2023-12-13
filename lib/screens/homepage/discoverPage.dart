import 'dart:async';

import 'package:dara_app/main.dart';
import 'package:dara_app/screens/homepage/recommendations.dart';
import 'package:dara_app/screens/homepage/viewOffers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List skills = [
    "Plumbing",
    "Car Repairs",
    "Laundry",
    "Electrical Works",
    "Painting",
    "Carpentry",
    "Hair Salon",
    "Generator",
    "Cleaning",
    "Gas Refill",
    "Fumigation",
    "AC/Refrigerator",
    "Beautifaction/Makeup",
    "TV repair",
    "Home renovation",
    "Chef",
    "Catering",
    "Logistics/Dispatch",
    "Installation",
    "Gadget",
    "Photography/Videography",
    "Vehicle towing",
    "Vulcanizer",
    "Welder"
  ];

  int currentIndex = -1;
  late Position position;
  Completer<GoogleMapController> _controller = Completer();
  final SearchController = TextEditingController();
  GoogleMapController ?mapController;
  bool isLoading = true;
  bool findServices = false;

  late final CameraPosition googlePlex ;

  @override
  void initState() {
    print("The init state running successfully");
    setState(() {
      isLoading = true;
    });

    googlePlex = CameraPosition(
      target: LatLng(6.6442, 5.9304),
        zoom: 10,
      );
    determinePosition();
    super.initState();
  }

  @override
  void dispose(){
    mapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppData provider = Provider.of<AppData>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                
                padding: EdgeInsets.only(bottom: 6),
                mapType: MapType.normal,
                myLocationEnabled: false,
                initialCameraPosition: googlePlex,
                myLocationButtonEnabled: false,
                zoomGesturesEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  mapController = controller;
                   setState(() {
      
                    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                    target: LatLng(6.6442, 5.9304),
                      zoom: 10,
                    ))
                      
                    );
                  });
                },
              ),
            ),
      
            Column(
              children: [
                SizedBox(height: 60,),
                Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 52,
                              alignment: Alignment.center,
                              child:  SvgPicture.asset("assets/svg/search.svg"),
                            ),
                
                            Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width*0.75,
                              child: TextFormField(
                                  // focusNode: textNode,
                                  onChanged: (value){
                                setState(() {
                                  
                                });
                              },
                                  controller: SearchController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    focusedBorder:OutlineInputBorder(
                                  gapPadding: 0,
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                    hintText: "Search",
                                  ),
                                ),
                            )
                          ],
                        ),
                      ),
                    ),
      
                    SizedBox(height: 10,),
      
                    (SearchController.text.isNotEmpty)? Container(
                    height: 32,
                    // color: Colors.red,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: skills.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                currentIndex=index;
                              });
                            },
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: (currentIndex==index)? constants.appMainColor :Colors.white,
                                borderRadius: BorderRadius.circular(200)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    skills[index],
                                    style: TextStyle(
                                      color: (currentIndex==index)? Colors.white :Colors.black,
                                      fontSize: 12),),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  )
                  :SizedBox(),
      
                  Spacer(),
      
                  (findServices)? Container(
                    height: 148,
                    // color: Colors.red,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 148,
                            width: 224,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage("assets/profile1.png"),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Daniel Smith",
                                            style:
                                            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                PhosphorIcons.star_fill,
                                                color: Colors.orangeAccent,
                                                size: 13,
                                              ),
                                              Text(
                                                "4.2",
                                                style: TextStyle(fontSize: 10, color: Colors.black54),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Container(
                                                  height: 4.2,
                                                  width: 4.2,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.black54,
                                                  ),
                                                  child: Text(""),
                                                ),
                                              ),
                                              Text(
                                                "Plumber",
                                                style: TextStyle(fontSize: 10, color: Colors.black54),
                                              ),
                            
                                              
                                            ],
                                          ),
                                          
                                          Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: Text(
                                                  "50 meters away",
                                                  style: TextStyle(
                                                    fontSize: 10, 
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54),
                                                ),
                                              ),
                                         ],
                                      )
                                    ],
                                  ),
                            
                                  Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: Text(
                                                  "20 Recommended",
                                                  style: TextStyle(
                                                    fontSize: 8, 
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54),
                                                ),
                                              ),
                                
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Container(
                                                  height: 4.2,
                                                  width: 4.2,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                
                                              Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: Text(
                                                  "51 Completed Projects",
                                                  style: TextStyle(
                                                    fontSize: 8, 
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54),
                                                ),
                                              ),
                                            ],
                                          ),
                            
                                          Divider(),
                            
                                           InkWell(
                                             onTap: (){
                                              mywidgets.showHireSheet(context: context);
                                             },
                                             child: Container(
                                               // width: 69,
                                               height: 40,
                                               decoration: BoxDecoration(
                                                   color: Colors.white,
                                                   border: Border.all(
                                                       color: constants.appMainColor, width: 2),
                                                   borderRadius: BorderRadius.circular(200)
                                               ),
                                               child: Center(
                                                 child: Text(
                                                   "Hire me",
                                                   style: TextStyle(
                                                       color:   constants.appMainColor,
                                                       fontSize: 14),),
                                               ),
                                             ),
                                           ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  )
                  :SizedBox(),
      
                  SizedBox(height: 20,),
      
                 (findServices == false)? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            findServices = true;
                          });
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: constants.appMainColor,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                                    
                              Text("Find Services near me",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),

                              SizedBox(width: 5,),
                      
                              Container(
                                          height: 20,
                                          width: 20,
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset("assets/svg/gps.svg")),
                            ],
                          ),
                        ),
                      ),
                    )
                    :Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return Recommendation();
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
                          height: 48,
                          decoration: BoxDecoration(
                            color: constants.appMainColor,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                                    
                              Text("See all",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                      
                              Container(
                                height: 48,
                                width: 52,
                                child: Icon(Icons.arrow_forward, color: Colors.white,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
      
                    SizedBox(height: 40,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setupPositionLocator() async {

    print(">>>>>>>>>>>>>>>>>>>> Set up position started");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 18.0);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(cp));
  }



  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {


      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        // circularCustom(context, "Location permissions are denied");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // circularCustom(context, "Location permissions are permanently denied, we cannot request permissions.");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


     position =  await Geolocator.getCurrentPosition();

    //   var response =
    //   await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude.toString()},${position.longitude.toString()}&radius=1000&key=${mapKey}'),
    //       headers: {
    //         "Content-type": "application/json",
    //         // 'Authorization': 'Bearer $bearer',
    //       });
    //   var body = json.decode(response.body);

      
    //   print(body);

    //   if (response.statusCode  <= 300) {

    //   print(">>>>>>>>>>>>>>>>>>>About to print the result body of the response");
    //   print(body["results"]);

    // //  List result = body["results"];
    // //  result.shuffle();
    // //  result.shuffle();
    // //  List newList  = result.sublist(1,result.length);
    // // Provider.of<AppData>(context, listen: false).setSuggestedPlaces(newList);

    
    //   } else {
    //     print('failed');
    //   }
  }
}
