import '../../../main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/Bank/banks.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/withdrawFunds.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String? transactionPeriod = "All time";
  var period = [
    'All time',
    "Last Week",
    "Last month",
  ];

  var user_object;
  Map? banks;
  List? history;

  @override
  initState() {
    super.initState();
    DataProvider provider = Provider.of<DataProvider>(context, listen: false);
    reloadUserObject().then((value) {
      setState(() {
        user_object = value;
      });
      if ((provider.userType == "serviceProvider")) {
        provider.set_sp_login_info(
            value: value,
            firstName: value["user_object"]["personal_information"]
                ["first_name"],
            lastName: value["user_object"]["personal_information"]["last_name"],
            email: value["user_object"]["personal_information"]["email"],
            id: value["user_object"]["personal_information"]["id"].toString(),
            access_token: value["access_token"],
            profile_image: (value["user_object"]["address_information"] != null)
                ? value["user_object"]["address_information"]["profile_image"]
                : "");
      } else {
        provider.set_client_login_info(
            value: value,
            firstName: value["user_object"]["personal_information"]
                ["first_name"],
            lastName: value["user_object"]["personal_information"]["last_name"],
            email: value["user_object"]["personal_information"]["email"],
            id: value["user_object"]["personal_information"]["id"].toString(),
            access_token: value["access_token"],
            profile_image: (value["user_object"]["address_information"] != null)
                ? value["user_object"]["address_information"]["profile_image"]
                : "");
      }
    });

    fetchBanks().then((value) {
      setState(() {
        banks = value;
      });
    });

    fetchHistory().then((value) {
      setState(() {
        history = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Text("")),
          centerTitle: false,
          titleSpacing: 0,
          title: Transform(
            transform: Matrix4.translationValues(-55, 0, 0),
            child: Row(
              children: [
                Padding(
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
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Wallet",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return Banks();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            )).then((value) {
                          fetchBanks().then((value) {
                            setState(() {
                              banks = value;
                            });
                          });
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: constants.appMainColor),
                            borderRadius: BorderRadius.circular(200)),
                        child: Center(
                          child: Text(
                            "Banks",
                            style: TextStyle(
                                color: constants.appMainColor, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: user_object == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 124,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: constants.appMainColor,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Container(
                                      width: 74.68,
                                      height: 104,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/daraLogoGrey.png"),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    height: 84,
                                    width: MediaQuery.of(context).size.width *
                                        0.47,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Available Balance",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "NGN ${provider.value["user_object"]["personal_information"]["wallet"]}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Spacer(),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Total Wallet Balance: ',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                              TextSpan(
                                                text:
                                                    'NGN ${provider.value["user_object"]["personal_information"]["wallet"]}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Container(
                                      width: 74.68,
                                      height: 104,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/daraLogoGrey.png"),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 24,
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transaction History",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5),
                                  height: 24,
                                  width: 104,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 1, color: Color(0XFFE5E7EB))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black38,
                                      ),
                                      hint: Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      items: period
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ))
                                          .toList(),
                                      value: transactionPeriod,
                                      onChanged: (value) {
                                        setState(() {
                                          transactionPeriod = value as String;
                                        });
                                      },
                                      buttonHeight: 40,
                                      buttonWidth: 140,
                                      itemHeight: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.52,
                              // color: Colors.red,
                              child: history == null
                                  ? Center(child: CircularProgressIndicator())
                                  : history!.length == 0
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                "No History Found",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                            ),
                                          ],
                                        )
                                      : ListView.builder(
                                          itemCount: history == null
                                              ? 0
                                              : history!.length,
                                          itemBuilder: (context, index) {
                                            return incomeCard(index);
                                            // : withdrawalCard();
                                          })),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 84,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(4, 0),
                              blurRadius: 8,
                              spreadRadius: 0,
                            )
                          ],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: InkWell(
                            onTap: () {
                              print(banks);
                              if (banks == {}) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Update bank details, before you can proceed.");
                              } else {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return WithdrawFunds();
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
                                    fetchHistory().then((value) {
                                      setState(() {
                                        history = null;
                                        history = value;
                                      });
                                    });
                                  });
                                });
                              }
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
                                  "Withdraw",
                                  style: TextStyle(
                                      color: constants.appMainColor,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )));
  }

  incomeCard(index) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //         context,
        //         PageRouteBuilder(
        //           pageBuilder: (context, animation, secondaryAnimation) {
        //             return ViewProject(selected: selected);
        //           },
        //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //             return FadeTransition(
        //               opacity: animation,
        //               child: child,
        //             );
        //           },
        //         )
        //       );
      },
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
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0XFFDCFCE7)),
                          child: Container(
                              height: 24,
                              width: 24,
                              alignment: Alignment.center,
                              child: SvgPicture.asset("assets/svg/import.svg")),
                        )),
                    Container(
                      height: 48,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 3),
                            // color: Colors.green,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              "Withdrawal Request. ",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF374151)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "${GetTimeAgo.parse(DateTime.parse(history![index]["created_at"]))}",
                              style: TextStyle(
                                  fontSize: 10, color: Color(0XFF374151)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // color: Colors.blue,
                height: 48,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text(
                  "NGN ${history![index]["amount"]}",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Divider(),
          )
        ],
      ),
    );
  }

  withdrawalCard() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //         context,
        //         PageRouteBuilder(
        //           pageBuilder: (context, animation, secondaryAnimation) {
        //             return ViewProject(selected: selected);
        //           },
        //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //             return FadeTransition(
        //               opacity: animation,
        //               child: child,
        //             );
        //           },
        //         )
        //       );
      },
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
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0XFFFEE2E2)),
                          child: Container(
                              height: 24,
                              width: 24,
                              alignment: Alignment.center,
                              child: SvgPicture.asset("assets/svg/export.svg")),
                        )),
                    Container(
                      height: 48,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 3),
                            // color: Colors.green,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              "You made a withdrawal into your bank account",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF374151)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "21/04/23 - 08/05/23",
                              style: TextStyle(
                                  fontSize: 10, color: Color(0XFF374151)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // color: Colors.blue,
                height: 48,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text(
                  "N 20,0000",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ],
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
