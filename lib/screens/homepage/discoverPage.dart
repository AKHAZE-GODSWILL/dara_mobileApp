import 'dart:async';
import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dara_app/screens/homepage/recommendations.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/serviceProviderAccount.dart';

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
  GoogleMapController? mapController;
  bool isLoading = true;
  bool findServices = false;
  bool isSearching = false;
  List<dynamic> serviceProviders = [];
  late final CameraPosition googlePlex;

  @override
  void initState() {
    print("The init state running successfully");
    setState(() {
      isLoading = true;
    });

    googlePlex = const CameraPosition(
      target: LatLng(6.6442, 5.9304),
      zoom: 10,
    );
    determinePosition();
    super.initState();
  }

  @override
  void dispose() {
    mapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppData provider = Provider.of<AppData>(context, listen: true);
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
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
                    mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(6.6442, 5.9304),
                      zoom: 10,
                    )));
                  });
                },
              ),
            ),

            // Spacer()
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
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
                            child: (isSearching)
                                ? CircularProgressIndicator()
                                : SvgPicture.asset("assets/svg/search.svg"),
                          ),
                          Container(
                            height: 48,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              // focusNode: textNode,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    isSearching = true;
                                    serviceProviders.clear();
                                  });
                                  searchServiceProviders(query: value.trim())
                                      .then((value) {
                                    print(
                                        "The final Value of what was resulted from the request was :$value");

                                    if (value["status"] == true) {
                                      setState(() {
                                        // getX.write((widget.userType == "serviceProvider")? constants.GETX_SP_FEEDS:constants.GETX_CLIENT_FEEDS, value["user_object"]["posts"]);
                                        // serviceProviders.clear();
                                        serviceProviders = value["data"];
                                        print(serviceProviders);
                                      });
                                    } else if (value["status"] ==
                                        "Network Error") {
                                      mywidgets.displayToast(
                                          msg:
                                              "Network Error. Check your Network Connection and try again");
                                    } else {
                                      mywidgets.displayToast(
                                          msg: value["message"]);
                                    }

                                    setState(() {
                                      // isLoading = false;
                                      isSearching = false;
                                    });
                                  });
                                } else {
                                  setState(() {
                                    isSearching = false;
                                  });
                                }
                              },
                              controller: SearchController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
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
                  SizedBox(
                    height: 10,
                  ),
                  (SearchController.text.isNotEmpty)
                      ? Container(
                          height: 32,
                          // color: Colors.red,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: skills.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                    child: Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                          color: (currentIndex == index)
                                              ? constants.appMainColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            skills[index],
                                            style: TextStyle(
                                                color: (currentIndex == index)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  (SearchController.text.isNotEmpty)
                      ? Expanded(
                          // color: Colors.white,
                          // height: MediaQuery.of(context).size.height*0.7,
                          child: Material(
                            color: Colors.white,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: serviceProviders.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Container(
                                    height: 68,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: Color(0XFFE5E7EB),
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Map<String, String> user = {
                                                  "first_name":
                                                      serviceProviders[index]
                                                          ["first_name"],
                                                  "last_name":
                                                      serviceProviders[index]
                                                          ["last_name"],
                                                  "user_id": serviceProviders[
                                                          index]
                                                      ["service_provider_id"]
                                                };
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ServiceProviderAccount(
                                                                user: user)));
                                              },
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: AssetImage(
                                                    "assets/profile1.png"),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${serviceProviders[index]["first_name"]} ${serviceProviders[index]["last_name"]}",
                                                style: GoogleFonts.inter(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    PhosphorIcons.star_fill,
                                                    color: Colors.orangeAccent,
                                                    size: 13,
                                                  ),
                                                  Text(
                                                    "4.2",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0XFF6B7280)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      height: 4.2,
                                                      width: 4.2,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0XFF6B7280),
                                                      ),
                                                      child: Text(""),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Plumber",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0XFF6B7280)),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      "20 Recommended",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0XFF6B7280)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      height: 4.2,
                                                      width: 4.2,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0XFF6B7280),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      "51 Completed Projects",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0XFF6B7280)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: InkWell(
                                              onTap: () {
                                                mywidgets.showHireSheet(
                                                    context: context,
                                                    sp_id: serviceProviders[
                                                            index][
                                                        "service_provider_id"]);
                                              },
                                              child: Container(
                                                width: 69,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: constants
                                                            .appMainColor,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200)),
                                                child: Center(
                                                  child: Text(
                                                    "Hire me",
                                                    style: GoogleFonts.inter(
                                                        color: constants
                                                            .appMainColor,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Expanded(
                          // height: MediaQuery.of(context).size.height*0.75,
                          child: Column(
                            children: [
                              Spacer(),
                              // SizedBox(height: MediaQuery.of(context).size.height*0.7,),
                              (findServices)
                                  ? Container(
                                      height: 148,
                                      // color: Colors.red,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 3,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Container(
                                                height: 148,
                                                width: 224,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8.0),
                                                            child: CircleAvatar(
                                                              radius: 25,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      "assets/profile1.png"),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Daniel Smith",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    PhosphorIcons
                                                                        .star_fill,
                                                                    color: Colors
                                                                        .orangeAccent,
                                                                    size: 13,
                                                                  ),
                                                                  Text(
                                                                    "4.2",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black54),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          4.2,
                                                                      width:
                                                                          4.2,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: Colors
                                                                            .black54,
                                                                      ),
                                                                      child: Text(
                                                                          ""),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Plumber",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black54),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        2.0),
                                                                child: Text(
                                                                  "50 meters away",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black54),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Text(
                                                              "20 Recommended",
                                                              style: TextStyle(
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Container(
                                                              height: 4.2,
                                                              width: 4.2,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Text(
                                                              "51 Completed Projects",
                                                              style: TextStyle(
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(),
                                                      InkWell(
                                                        onTap: () {
                                                          mywidgets.showHireSheet(
                                                              context: context,
                                                              sp_id: serviceProviders[
                                                                      index][
                                                                  "service_provider_id"]);
                                                        },
                                                        child: Container(
                                                          // width: 69,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: constants
                                                                      .appMainColor,
                                                                  width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          200)),
                                                          child: Center(
                                                            child: Text(
                                                              "Hire me",
                                                              style: TextStyle(
                                                                  color: constants
                                                                      .appMainColor,
                                                                  fontSize: 14),
                                                            ),
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
                                  : SizedBox(),

                              SizedBox(
                                height: 20,
                              ),

                              (findServices == false)
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            findServices = true;
                                          });
                                        },
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: constants.appMainColor,
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Find Services near me",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: 20,
                                                  width: 20,
                                                  alignment: Alignment.center,
                                                  child: SvgPicture.asset(
                                                      "assets/svg/gps.svg")),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return Recommendation();
                                                },
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  );
                                                },
                                              ));
                                        },
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: constants.appMainColor,
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "See all",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                height: 48,
                                                width: 52,
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        ),
                ],
              ),
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

    position = await Geolocator.getCurrentPosition();

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
