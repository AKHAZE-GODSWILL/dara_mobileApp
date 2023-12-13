
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dara_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_search_place/google_search_place.dart';
import 'package:google_search_place/model/prediction.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
// import '../../Utils/utils.dart';


class SearchPlace extends StatefulWidget {
  String ?title;
  SearchPlace({this.title});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> with TickerProviderStateMixin {
  double portforlioHeight = 55.0;
  int currentindex = 0;
  TabController? tabController;
  bool active = false;

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  // Country _selectedCountry  = Country("Nigeria", "flags/nga.png", "NG", "+234");
  TextEditingController controller = TextEditingController();

  // var auth = FirebaseAuth.instance;


  var pickupController = TextEditingController();
  var destinationController = TextEditingController();

  var focusDestination = FocusNode();






  bool done = false;


  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }
  final TextEditingController _searchPlaceController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // AuthProvider authProvider = Provider.of<AuthProvider>(context, listen:true);
    // InvoiceService invoiceProvider = Provider.of<InvoiceService>(context, listen: true);
    // InvoiceService invoiceService = Provider.of<InvoiceService>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 5,
          child: Container(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                  ),
                ),
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 0),
                          child: Container(
                            margin: EdgeInsets.only(top: 0),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                )),
                            child: SingleChildScrollView(
                              // physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(top: 25, bottom: 0),
                                      child: Row(
                                        children: [
                                          //
                                          Spacer(),
                                          IconButton(
                                            padding: EdgeInsets.all(5),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(MdiIcons.close,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0, right: 0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:8.0, right:8),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "${widget.title}",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only( top: 5, bottom:5, left:8.0, right:8),
                                            child: Text("",
                                              style: TextStyle(color: Colors.black54), textAlign: TextAlign.center,),
                                          ),









                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.75,
                                            // color: Colors.red,
                                            child:   Column(
                                              children: [


                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                        // height: 60,
                                                        // decoration: BoxDecoration(
                                                        //     color: Color(0xFFEEEEEE),
                                                        //     borderRadius: BorderRadius.circular(4)),
                                                        child:Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: SearchPlaceAutoCompletedTextField(
                                                                      inputDecoration:  InputDecoration(
                                                                        suffixIcon: Icon(PhosphorIcons.light.mapPin, color: Constants().appMainColor,),
                                                                        hintText: 'Enter Address',
                                                                        // fillColor: Color(0xFFEEEEEE),
                                                                        // filled: true,
                                                                        border: OutlineInputBorder(
                                                                            borderSide: BorderSide(width: 0.8, color: Colors.black26)
                                                                        ),
                                                                        enabledBorder: OutlineInputBorder(
                                                                            borderSide: BorderSide(width: 0.8, color: Colors.black26)
                                                                        ),
                                                                        focusedBorder:  OutlineInputBorder(
                                                                            borderSide: BorderSide(width: 0.8, color: Colors.black26)
                                                                        ),
                                                                        isDense: true,
                                                                        contentPadding: EdgeInsets.only(
                                                                            left: 10, top: 8, bottom: 8),
                                                                      ),
                                                                      googleAPIKey: Constants().mapKey,
                                                                      controller: _searchPlaceController,
                                                                      countries: ["NG"],
                                                                      itmOnTap: (Prediction prediction) {
                                                                        _searchPlaceController.text = prediction.description ?? "";

                                                                        _searchPlaceController.selection = TextSelection.fromPosition(
                                                                            TextPosition(
                                                                                offset: prediction.description?.length ?? 0));


                                                                      },
                                                                      getPlaceDetailWithLatLng: (Prediction prediction) {
                                                                        _searchPlaceController.text = prediction.description ?? "";

                                                                        _searchPlaceController.selection = TextSelection.fromPosition(
                                                                            TextPosition(
                                                                                offset: prediction.description?.length ?? 0));

                                                                        // Get search place latitude and longitude
                                                                        print("${prediction.lat} ${prediction.lng}");
                                                                        Map place = {
                                                                          "longitude": prediction.lng.toString(),
                                                                          "latitude": prediction.lat.toString(),
                                                                          "mainText": "${prediction.placeDetails!.result!.name.toString()}"
                                                                        };
                                                                        // Navigator.pop(context);
                                                                        Navigator.pop(context, place);
                                                                        // Navigator.pop(context,  "${prediction.placeDetails!.result!.name.toString()}");

                                                                        // Get place Detail
                                                                        // print("Place Detail : ${prediction.placeDetails!.result!.formattedAddress.toString()}");
                                                                      }),
                                                                )],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),




                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }



}

