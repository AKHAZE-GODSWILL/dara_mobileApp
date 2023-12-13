import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
// import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Firebase/Firebase_service.dart';
import '../../Firebase/Utils/Provider.dart';
import '../../Firebase/Utils/colors.dart';
import '../../Firebase/Utils/utils.dart';
import '../../Firebase/Widgets/messages_widget.dart';


class ChatPage extends StatefulWidget {
  final itemid;
  final productSend;
  final productData;
  final user;
  final instantChat;
  final popData;
  final LocalFileSystem localFileSystem;
  final bool newchat; //to know if it is chat from old ID or new chat
  final bool support; //to know if it is customer support or to tradee
  // final dynamic? shipments;
  // final String? pickup;
  final bool? navigate;
  // final String? dropoff;
  ChatPage({
    this.productSend,
    this.productData,
    this.navigate,
    this.instantChat,
    this.popData,
    this.itemid,
    required this.newchat,
    required this.support,
     // this.shipments,
     // this.pickup,
     // this.dropoff,

    localFileSystem,
    @required this.user,
  }) : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //FocusNode textFieldFocus = FocusNode();
  bool recordStatus = false;

  // FlutterAudioRecorder2? _recorder;
  // Recording? _current;
  // RecordingStatus? _currentStatus = RecordingStatus.Unset;

  final _controller = TextEditingController();

  // final _controller2 = TextEditingController();
  String message = '';

  sendMessageTriggerFirst() async {
    var utils = Provider.of<Utils>(context, listen: false);
    message = widget.newchat == true &&
            widget.support ==
                false // if it is a new chatfrom giftcard and not support chat
        ? """Hey, i would love to make trade with GOLDENPAY!. \n\n Amount To Get: \u{20A6}${widget.productData['amounttoget']}\n Rate: \$${widget.productData['rate']}\n Amount: \u{20A6}${widget.productData['amount']} \n Pieces: ${widget.productData['pieces']} \n Category: ${widget.productData['categoryname']} \n SubCategory: ${widget.productData['subcategoryname']} \n CardID: ${widget.itemid}."""
        : widget.newchat == false &&
                widget.support ==
                    false // if it is a resuming  chatfrom giftcard and not support chat
            ? """Hey, i would love to resume trade with GOLDENPAY!. \n\n Amount To Get: \u{20A6}${widget.productData['amounttoget']}\n Rate: \$${widget.productData['rate']}\n Amount: \u{20A6}${widget.productData['amount']} \n Pieces: ${widget.productData['pieces']} \n Category: ${widget.productData['categoryname']} \n SubCategory: ${widget.productData['subcategoryname']} \n CardID: ${widget.itemid}."""
            : """ ${widget.productData['msg']}"""; // it is purely for support

    String productImage;

    await FirebaseApi.uploadmessage(widget.user.idUser, utils.userId, message,
        context, '${utils.userId}-${widget.user.id}', widget.user.name
        // productImage: productImage,
        );
    // sendAndRetrieveMessage(message, widget.user.fcmToken);
  }
  // List<DeliveryLocationModel>? delivery;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.shipments.toJson());
    // ShipmentProvider shipmentProvider =
    // Provider.of<ShipmentProvider>(context, listen: false);
    // print(widget.shipments.deliveryID);
    // print(widget.shipments.id);
    // print(widget.shipments.ids);


    // shipmentProvider.getDeliveryLocation(
    //     widget.shipments.id==null&&widget.shipments.ids==null?
    //     widget.shipments.deliveryID:
    //     widget.shipments.id==null&&widget.shipments.deliveryID==null?
    //     widget.shipments.ids:
    //     widget.shipments.ids==null&&widget.shipments.deliveryID==null?
    //     widget.shipments.id:widget.shipments.id
    // )
    //     .then((e){
    //   setState((){
    //     delivery = e;
    //     // print(delivery);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Utils>(context, listen: false);
    var datas = Provider.of<DataProviders>(context, listen: false);
    var utils = Provider.of<Utils>(context, listen: false);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    void pickImage({required ImageSource source, context}) async {
      final picker = ImagePicker();
      var selectedImage = await picker.pickImage(source: source);
      FocusScope.of(context).unfocus();
      // _controller2.clear();
      FirebaseApi.uploadCheckChat(widget.user.idUser);
      _controller.clear();
      datas.setWritingTo(false);
      await FirebaseApi.uploadImage(
              widget.user.idUser,
              utils.userId,
              selectedImage,
              context,
              '${utils.userId}-${widget.user.id}',
              false,
              widget.user.name)
          .then((value) {
        // sendAndRetrieveMessage(message, widget.user.fcmToken);
      });
    }

    pickDoc() async {
      final selectedImage = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'csv',
        'xls',
        'xlsx',
        'ods',
        'txt',
        'html',
        'png',
        'jpeg',
        'jpg',
        'gif'
      ]);

      FocusScope.of(context).unfocus();
      FirebaseApi.uploadCheckChat(widget.user.idUser);

      // _controller2.clear();
      _controller.clear();
      datas.setWritingTo(false);
      await FirebaseApi.uploadImage(
          widget.user.idUser,
          utils.userId,
          selectedImage,
          context,
          '${utils.userId}-${widget.user.id}',
          true,
          widget.user.name);
      // sendAndRetrieveMessage(message, widget.user.fcmToken);
    }

    void record({record, context}) async {
      FocusScope.of(context).unfocus();
      FirebaseApi.uploadCheckChat(widget.user.idUser);
      _controller.clear();
      datas.setWritingTo(false);
      await FirebaseApi.uploadRecord(widget.user.idUser, utils.userId, record,
          context, '${utils.userId}-${widget.user.id}', widget.user.name);
      // sendAndRetrieveMessage(message, widget.user.fcmToken);
    }

    sendMessage() async {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      FirebaseApi.uploadCheckChat(widget.user.idUser);
      _controller.clear();
      datas.setWritingTo(false);
      await FirebaseApi.uploadmessage(
          widget.user.idUser,
          utils.userId,
          message,
          context,
          '${utils.userId}-${widget.user.id}',
          widget.user.name);
      // sendAndRetrieveMessage(message, widget.user.fcmToken);
    }

    var numberDialog = AnimatedContainer(
      height: 80,
      duration: Duration(seconds: 1),
      margin: const EdgeInsets.all(3.0),
      child: Align(
        alignment: Alignment(0.75, 0.75),
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                child: AnimatedContainer(
                  height: 80,
                  duration: Duration(seconds: 1),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: StatefulBuilder(builder: (context, setState) {
                          return Container(
                            height: 80.0,
                            color: Colors.transparent,
                            //could change this to Color(0xFF737373),
                            //so you don't have to change MaterialApp canvasColor
                            child: Column(
                              children: [
                                Card(
                                  color: Colors.white,
                                  // padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          pickDoc();
                                        },
                                        child: Tab(
                                            icon: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color:
                                                        messagesendercontainercolor,
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.attachment,
                                                  color: Colors.white,
                                                )),
                                            text: 'Attachment'),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          pickImage(
                                              source: ImageSource.camera,
                                              context: context);
                                        },
                                        child: Tab(
                                            icon: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color:
                                                        messagesendercontainercolor,
                                                    shape: BoxShape.circle),
                                                child: Icon(Icons.camera_alt,
                                                    color: Colors.white)),
                                            text: 'Camera'),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          pickImage(
                                              source: ImageSource.gallery,
                                              context: context);
                                        },
                                        child: Tab(
                                            icon: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color:
                                                        messagesendercontainercolor,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Icon(Icons.image,
                                                      color: Colors.white),
                                                )),
                                            text: 'Gallary'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  bottom: 30,
                ),
                child: InkWell(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    Navigator.pop(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: messagesendercontainercolor,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    void _modalBottomSheetMenu(datas) {
      showGeneralDialog(
          barrierColor: Colors.transparent,
          transitionBuilder: (context, a1, a2, widget) {
            final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
            return Transform(
              transform:
                  Matrix4.translationValues(0.0, curvedValue * -200, 0.0),
              child: Opacity(opacity: a1.value, child: numberDialog),
            );
          },
          transitionDuration: Duration(milliseconds: 500),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {
            throw '';
          });
    }

    Widget scaffold = Scaffold(
      // appBar: AppBar(
      //   backgroundColor: messagesendercontainercolor,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //       _stopExit();
      //       initilizeExit();
      //     },
      //     icon: Icon(
      //       Icons.arrow_back,
      //     ),
      //   ),
      //   centerTitle: false,
      //   title: Text(
      //     '${widget.user.name}'.capitalizeFirstOfEach,
      //   ),
      //   actions: <Widget>[
      //     widget.user.idUser == null ||
      //             widget.user.idUser.toString().isEmpty ||
      //             utils.userId == null
      //         ? Text('')
      //         : SizedBox(),

      // IconButton(
      //     icon: Icon(
      //       Icons.videocam,
      //       size: 30,
      //     ),
      //     onPressed: () {
      //     },
      //   ),
      // IconButton(
      //   icon: Icon(
      //     Icons.phone,
      //     size: 25,
      //   ),
      //   onPressed: widget.user.idUser == null ||
      //           widget.user.idUser.toString().isEmpty ||
      //           utils.userId == null
      //       ? () {
      //           data.makePhoneCall(widget.user.userMobile);
      //         }
      //       : () {
      //         },
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(right: 10.0),
      //   child: PopUpMenu(
      //       idUser: widget.user.idUser,
      //       user: widget.user,
      //       scaffoldKey: scaffoldKey,
      //       popData: widget.popData),
      // ),

      //   ],
      // ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () {
          if(widget.navigate ==true){
            // Navigator.pop(context);
            // Navigator.pop(context);
            // Navigator.pop(context);
            // Navigator.pop(context);

          }else{
            Navigator.pop(context);
          }
          // _stopExit();
          // initilizeExit();

          throw '';
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              color: Colors.white,
              // child: Image.asset(
              //   'assets/images/chat.png',
              //   fit: BoxFit.cover,
              // ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Container(
                    color: messagesendercontainercolor,
                    height: 115,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, bottom: 0, top: 30),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Icon(PhosphorIcons.caret_left_light,
                                          size: 25, color: Colors.white),
                                    ),
                                    // SizedBox(width: 4),
                                    // Text(
                                    //   '${widget.user.urlAvatar}',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w400,
                                    //       color: Colors.white,
                                    //       fontSize: 16),
                                    // ),
                                  ],
                                ),
                              ),
                              // Spacer(),
                              // Image.asset(
                              //   'assets/images/index/Logo.png',
                              //   // scale: 1.2,
                              //   width: 150,
                              // )
                              CircleAvatar(
                                foregroundColor:
                                Colors.white,
                                backgroundColor:
                                Colors.white,
                                radius:
                                30,
                                backgroundImage: widget.user.urlAvatar ==
                                    ""
                                    ? AssetImage(
                                    "image/user.png")
                                    : NetworkImage(widget.user.urlAvatar)
                                as ImageProvider,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.user.name}".capitalize(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            // var data = Provider.of<Utils>(context, listen: false);
                                            // var date = data.compareDateChat(widget.user.lastMessageTime);
                                            return Padding(
                                              padding: const EdgeInsets.only(top:6.0),
                                              child: Text(
                                                "Active ${GetTimeAgo.parse(widget.user.lastMessageTime)}",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            );
                                          }
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Future<void> _launchUrl(_url) async {
                                        if (!await launchUrl(_url)) {
                                          throw 'Could not launch $_url';
                                        }
                                      }
                                      final Uri _url = Uri.parse('tel:+2340${widget.user.userMobile}');

                                      _launchUrl(_url);

                                      

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right:8.0, top:5, bottom:5),
                                      child: Icon(PhosphorIcons.phone,
                                          size: 30, color: Colors.white),
                                    ),
                                  ),

                                  // SizedBox(width: 4),
                                  // Text(
                                  //   '${widget.user.urlAvatar}',
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w400,
                                  //       color: Colors.white,
                                  //       fontSize: 16),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: MessagesWidget(
                        idUser: widget.user.idUser, user: widget.user),
                  ),
                ),
                StatefulBuilder(builder: (context, setState) {
                  return Container(
                    height: 65,
                    color: Colors.white,
                    child: widget.user.idUser == null ||
                            widget.user.idUser.toString().isEmpty
                        ? Center(
                            child: Text(
                            'You Cannot Send Message. You can Contact the user through direct Phone Call by Clicking the phone Icon above',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 13,
                              ),

                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      color: Color(0xFFF4F6FF),
                                      height: 60,
                                      width: recordStatus
                                          ? MediaQuery.of(context).size.width /
                                              1.26
                                          : MediaQuery.of(context).size.width /
                                              1.26,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: TextField(
                                          onTap: () async {
                                            String? token =
                                                await FirebaseMessaging.instance
                                                    .getToken();
                                            FirebaseApi.updateUsertoRead(
                                                idUser: widget.user.idUser,
                                                idArtisan: utils.userId);

                                            if (widget.user.fcmToken
                                                    .toString() !=
                                                token) {
                                              FirebaseApi.updateUserFCMToken(
                                                idUser: widget.user.idUser,
                                                idArtisan: utils.userId,
                                                token: token,
                                              );
                                            }
                                          },
                                          controller: _controller,
                                          onChanged: (val) {
                                            (val.length > 0 && val.trim() != "")
                                                ? datas.setWritingTo(true)
                                                : datas.setWritingTo(false);
                                            message = val;
                                            setState(() {});
                                          },
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autocorrect: true,
                                          // focusNode: textFieldFocus,
                                          enableSuggestions: true,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            hintText: 'Type a message...',
                                            hintStyle: TextStyle(
                                                color: Colors.black54),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            isDense: true,
                                            filled: true,
                                            fillColor: Color(0xFFF4F6FF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 15,
                                    right: 15,
                                    child: InkWell(
                                      onTap: () {
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                        _modalBottomSheetMenu(datas);
                                      },
                                      child: Image.asset(
                                        "image/lik.png",
                                        scale: 0.8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 9),
                                decoration: BoxDecoration(
                                    color: messagesendercontainercolor,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 58,
                                width: 58,
                                child: Center(
                                  child: IconButton(
                                    onPressed:
                                        datas.isWriting ? sendMessage : () {},
                                    icon: Icon(Icons.send, color: Colors.white),
                                  ),
                                ),
                              )

                              // : Container(
                              //     margin: EdgeInsets.only(left: 5),
                              //     decoration: BoxDecoration(
                              //         color: messagesendercontainercolor,
                              //         borderRadius:
                              //             BorderRadius.circular(100)),
                              //     height: 44,
                              //     width: 44,
                              //     child: Center(
                              //       child: IconButton(
                              //         onPressed: () {
                              //           setState(() {
                              //             recordStatus = true;
                              //           });
                              //           switch (_currentStatus) {
                              //             case RecordingStatus
                              //                 .Initialized:
                              //               {
                              //                 _start();
                              //                 break;
                              //               }
                              //             case RecordingStatus.Stopped:
                              //               {
                              //                 initilize();
                              //                 break;
                              //               }
                              //             default:
                              //               break;
                              //           }
                              //         },
                              //         icon: Icon(
                              //           Icons.mic,
                              //           color: Colors.white,
                              //           size: 30,
                              //         ),
                              //       ),
                              //     ),
                              //   )
                              //;
                              //   },
                              // ),
                            ],
                          ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );

    return scaffold;
  }
}

//message.trim().isEmpty
//? null
//:
