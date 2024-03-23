import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/Bank/addBank.dart';

class Banks extends StatefulWidget {
  const Banks({super.key});

  @override
  State<Banks> createState() => _BanksState();
}

class _BanksState extends State<Banks> {
  Map? banks;
  List? bank_list;
  @override
  initState() {
    super.initState();
    fetchBanks().then((value) {
      setState(() {
        banks = value;
      });
    });

    fetchOfficialBanks().then((value) {
      setState(() {
        bank_list = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Text("")
        ),
        centerTitle: false,
        titleSpacing: 0,
        title: Transform(
          transform: Matrix4.translationValues(-55, 0, 0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "Bank",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: (banks == null || bank_list == null)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ],
            )
          : banks!.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 84,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: InkWell(
                          onTap: bank_list == null
                              ? () {}
                              : () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return AddBank(
                                            banks: bank_list,
                                          );
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      )).then((value) {
                                    setState(() {
                                      banks = null;
                                      fetchBanks().then((value) {
                                        setState(() {
                                          banks = value;
                                        });
                                      });
                                    });
                                  });
                                },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: constants.appMainColor),
                                borderRadius: BorderRadius.circular(200)),
                            child: Center(
                              child: Text(
                                "Add Bank",
                                style: TextStyle(
                                    color: constants.appMainColor,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          height: 48,
                                          width: 48,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Color(0XFFDCFCE7)),
                                          child: Container(
                                              height: 24,
                                              width: 24,
                                              alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                  "assets/svg/import.svg")),
                                        )),
                                    Container(
                                      height: 48,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(top: 3),
                                            // color: Colors.green,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              "${banks!["account_name"].toString()}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFF374151)),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              "${banks!["account_number"].toString()}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0XFF374151)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 84,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: InkWell(
                                onTap: bank_list == null
                                    ? () {}
                                    : () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return AddBank(
                                                  banks: bank_list,
                                                );
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
                                            )).then((value) {
                                          setState(() {
                                            banks = null;
                                            fetchBanks().then((value) {
                                              setState(() {
                                                banks = value;
                                              });
                                            });
                                          });
                                        });
                                      },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: constants.appMainColor),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Center(
                                    child: Text(
                                      "Update Bank",
                                      style: TextStyle(
                                          color: constants.appMainColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),
    );
  }
}
