import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class DataProviders extends ChangeNotifier {

  int count = 10;
  //String firebaseUserId = '';
  String overview = '';
  bool focusValue = false;
  String description = '';
  bool focusValue1 = false;
  bool splash = false;
  String productName = '';
  String productBio = '';
  String state = '';
  String adress = '';
  String city = '';
  String referalId = '';
  String productPrice = '';
  List subcat = [];
  bool focusValue2 = false;
  bool focusValue3 = false;
  bool focusValue4 = false;
  bool focusValue5 = false;
  bool isWriting = false;
  int selectedPage = 0;
  String emails = '';
  String businessName = '';
  String homeAddress = '';
  String bvn = '';
  String officeAddress = '';
  String otp = '';
  String firstName = '';
  String lastName = '';
  String artisanVendorChoice = '';
  bool passwordObscure = true;
  bool showCallToAction = true;
  String venueName = '' ;
  String addressVenue = '' ;
  String eventDuration = '' ;
  String eventCountry = '';
  String eventState = '';
  String eventCity = '';
  String eventName = '';
  String eventDescription = '';



  set setCallToActionStatus(bool newVal) {
    showCallToAction = newVal;
    notifyListeners();
  }

  setDescription(value) {
    description = value;
    notifyListeners();
  }

  setStateName(value){
    state = value;
    notifyListeners();
  }


  setCityName(value){
    city = value;
    notifyListeners();
  }




  setAddress(value){
    adress = value;
    notifyListeners();
  }

  setreferalId(value){
    referalId =  value;
    notifyListeners();
  }


  setBusinessName(value){
    businessName = value;
    notifyListeners();
  }
  //change password obcure text
  setSelectedBottomNavBar(value) {
    selectedPage = value;
    notifyListeners();
  }

  //change password obcure text
  setPassWordObscure(value) {
    passwordObscure = value;
    notifyListeners();
  }

  var userItems = [];
  var userItems1 = [];
  setUseritems(v1,v2){
    userItems.addAll(v2);
    notifyListeners();
  }

  setUseritems1(v1,v2){
    userItems1 = v1 + v2;
    notifyListeners();
  }


// combine all otp textfield as one
  setCombineOtpValue({cont1, cont2, cont3, cont4, cont5, cont6}) {
    otp =
        "${cont1.text}${cont2.text}${cont3.text}${cont4.text}${cont5.text}${cont6.text}";
    notifyListeners();
  }

  // check if  textfield firstNAme is empty or not
  setFirstName(value) {
    firstName = value;
    notifyListeners();
  }

  setSubCat(value) {
    subcat.add(value);
    notifyListeners();
  }

  setdelSubCat(value) {
    subcat.remove(value);
    notifyListeners();
  }

  setclrSubCat() {
    subcat.clear();
    notifyListeners();
  }

  setOverView(value) {
    overview = value;
    notifyListeners();
  }

  setArtisanVendorChoice(value) {
    artisanVendorChoice = value;
    notifyListeners();
  }

  // check if   BVN is empty or not
  setBVN(value) {
    bvn = value;
    notifyListeners();
  }

  // check if  textfield lastName is empty or not
  setLastName(value) {
    lastName = value;
    notifyListeners();
  }

  // check if  textfield homeAdress is empty or not
  sethomeAdress(value) {
    homeAddress = value;
    notifyListeners();
  }

  setProductName(value) {
    productName = value;
    notifyListeners();
  }

  setProductBio(value) {
    productBio = value;
    notifyListeners();
  }

  setProductPrice(value) {
    productPrice = value;
    notifyListeners();
  }

// check if  textfield officeAdress is empty or not
  setofficeAddress(value) {
    officeAddress = value;
    notifyListeners();
  }

  // check if  textfield email is empty or not
  setEmail(value) {
    emails = value;
    notifyListeners();
  }

  // check if  textfield password is empty or not


//change textfield number on focus of otp textfield
  setOTPfocusValue({focus1, focus2, focus3, focus4, focus5, focus6}) {
    focusValue = focus1;
    focusValue1 = focus2;
    focusValue2 = focus3;
    focusValue3 = focus4;
    focusValue4 = focus5;
    focusValue5 = focus6;
    notifyListeners();
  }

//end of **of otp textfield** function

//otp count down
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));



  // Future<void> _handleCameraAndMic(Permission permission) async {
  //   final status = await permission.request();
  // }

  setWritingTo(bool val) {
    isWriting = val;
    notifyListeners();
  }

  setSplash(bool val) {
    splash = val;
    notifyListeners();
  }

bool overlay = false;
  setOverLay(bool val) {
    overlay = val;
    notifyListeners();
  }

  String ?categorizeUrl(String s) {
    if (s.contains('https://firebasestorage.googleapis.com')) {
      var pos = s.lastIndexOf('.');
      String result = s.substring(pos + 1, s.length).toString().toLowerCase();
      if (result.contains('jpg') ||
          result.contains('jpeg') ||
          result.contains('png') ||
          result.contains('gif')) {
        return 'image';
      } else if (result.contains('pdf') ||
          result.contains('doc') ||
          result.contains('docx') ||
          result.contains('xls') ||
          result.contains('xlsx') ||
          result.contains('ods') ||
          result.contains('txt') ||
          result.contains('csv') ||
          result.contains('html')) {
        return 'doc';
      } else if (result.contains('wav') || result.contains('mp3')) {
        return 'audio';
      }
    } else {
      return 'link';
    }
  }
}
