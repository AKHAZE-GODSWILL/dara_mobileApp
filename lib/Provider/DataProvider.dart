
import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {

  int pageIndex = 0;
  String? userType;
  

  ////////////////////////// Client live style /////////////////////////////
  String? client_user_id;
  String? client_token;
  String? client_phone;
  String? client_email;
  String? client_first_name;
  String? client_last_name;

  String? client_country;
  String? client_state;
  String? client_lga;
  String? client_address;
  String? client_profile_image;


  /////////////////////////// Service providers info ////////////////////////
  String? sp_user_id;
  String? sp_token;
  String? serviceProviderPhone;
  String? sp_countryCallCode;
  String? sp_first_name;
  String? sp_last_name;
  String? sp_email;

  String? sp_country;
  String? sp_state;
  String? sp_lga;
  String? sp_address;
  String? sp_profile_image;
  String? sp_bio;
  String? sp_service;
  String? sp_skills;
  String? sp_experience;
  
  String? bankName;
  String? accountName;
  String? accountNumber;
  String? securityQuestion;
  String? securityAnswer;

  setValue(value){
    pageIndex = value;
    notifyListeners();
  }



  setUserType({required userTier}){
    userType = userTier;
    notifyListeners();
  }

  set_sp_user_id({required userId}){
    sp_user_id = userId;
    notifyListeners();
  }
  set_sp_token({required token}){
    sp_token = token;
    notifyListeners();
  }

  set_sp_phone({required service_provider_phone}){
    serviceProviderPhone = service_provider_phone;
    notifyListeners();
  }

  set_sp_personal_info({required firstName, required lastName, required email}){
    sp_first_name = firstName;
    sp_last_name = lastName;
    sp_email = email;
    notifyListeners();
  }

  set_sp_login_info({required firstName, required lastName, required email,required id, required access_token, required profile_image}){
    sp_first_name = firstName;
    sp_last_name = lastName;
    sp_email = email;
    sp_user_id = id;
    sp_token = access_token;
    sp_profile_image = profile_image;
    notifyListeners();
  }

  set_sp_address_info({required country, required state, required lga, required address}){
    sp_country = country;
    sp_state = state;
    sp_lga = lga;
    sp_address = address;
    notifyListeners();
  }

  set_sp_service_info({required profileImage, required bio, required service, required skills, required experience}){
    sp_profile_image = profileImage;
    sp_bio = bio;
    sp_service = service;
    sp_skills = skills;
    sp_experience = experience;
    notifyListeners();
  }

  set_sp_country_call_code({required country_call_code}){
    sp_countryCallCode = country_call_code;
    notifyListeners();
  }

  set_client_user_id({userId}){
    client_user_id = userId;
    notifyListeners();
  }

  set_client_token({required token}){
    client_token = token;
    notifyListeners();
  }

  set_client_email({required clientEmail}){
    client_email = clientEmail;
    notifyListeners();
  }

  set_client_personal_info({required firstName, required lastName, required email, required phone}){
    client_first_name = firstName;
    client_last_name = lastName;
    client_email = email;
    client_phone = phone;
    notifyListeners();
  }

  set_client_address_info({required profileImage,required country, required state, required lga, required address}){
    client_profile_image = profileImage;
    client_country = country;
    client_state = state;
    client_lga = lga;
    client_address = address;
    notifyListeners();
  }

  set_client_login_info({required firstName, required lastName, required email,required id, required access_token, required profile_image}){
    client_first_name = firstName;
    client_last_name = lastName;
    client_email = email;
    client_user_id = id;
    client_token = access_token;
    client_profile_image = profile_image;
    notifyListeners();
  }

  setBankDetails({required nameOfBank, required accNumber}){
    bankName = nameOfBank;
    accountNumber = accNumber;
    notifyListeners();
  }

  setSecurityDetails({required securedQuestion, required securedAnswer}){
    securityQuestion = securedQuestion;
    securityAnswer = securedAnswer;
    notifyListeners();
  }
}