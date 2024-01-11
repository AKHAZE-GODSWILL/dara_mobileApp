import 'dart:io';

import 'package:dara_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';

import 'package:provider/provider.dart';


 String url = 'base.usedara.com'; // Replace with your API endpoint

Future<dynamic> registerServiceProvider({required countryCallCode,required phoneNumber}) async {
  
  print("Register service provider started running");
  try{

  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> requestBody = {
    "phone": "${countryCallCode}${phoneNumber}"
  }; // Replace with your request data

  // print("Before postin the request");
  
  http.Client client = http.Client();
  // print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/signup/otp"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  // print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    // print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}

Future<dynamic> loginServiceProvider({required phoneNumber, required password}) async {
  
  // print("Register service provider started running");
  try{

  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> requestBody = {
    "phone":phoneNumber,
    "password":password
  }; // Replace with your request data

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/login"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;
    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}

Future<dynamic> verifyServiceProvider({required otp,required phoneNumber}) async {
  
  print("Register service provider started running");
  try{

  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> requestBody = {
    "phone": phoneNumber,
    "otp": otp
  }; // Replace with your request data

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/signup/otp/verify"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}

Future<dynamic> userServiceInformation({File? imageFile, required bio, required service, required skills, required experience, required user_id}) async {
  print("Register service provider started running");
  try {
    print("In the try method");

    String uri = 'https://base.usedara.com/api/v1/service-information';
    final request = http.MultipartRequest('Post', Uri.parse(uri));

    request.fields['user_id'] = user_id;
    request.fields['bio'] = bio;
    request.fields['service'] = service;
    request.fields['skills'] = skills;
    request.fields['experience'] = experience;
    

    if (imageFile != null) {
      final fileStream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final length = await imageFile.length();
      final multipartFile = http.MultipartFile('service_image', fileStream, length,
          filename: path.basename(imageFile.path));
      request.files.add(multipartFile); // Add the file to the request
    }

    final response = await request.send();
    
    
      final responseString = await response.stream.bytesToString();
      final jsonData = json.decode(responseString) as Map;
      // print("Request completed successfully");
      return jsonData;
  } on SocketException catch (e) {
    return {"status":"Network Error"};
  } on Error catch (e) {
    return {"status":"Some error occurred"};
  }
}

Future<dynamic> getServices() async {
  
  print("Register service provider started running");
  try{

  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.https(url,"/api/v1/services"),
    headers: headers,
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}

Future<dynamic> getSkills() async {
  
  print("Register service provider started running");
  try{

  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.https(url,"/api/v1/skills"),
    headers: headers
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}

Future<dynamic> serviceProviderPersonalInfo({ required phoneNumber ,required firstName,required lastName, required email, required password}) async {
  
  print("Register service provider started running");
  print("The phone number is $phoneNumber");
  print("The first name is $firstName");
  print("The last name is $lastName");
  print("The email is $email");
  print("The password is $password");
  try{

  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> requestBody = {
    "phone": phoneNumber,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password":password
  }; // Replace with your request data

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/signup/personal-details"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}

Future<dynamic> getOffers() async {
  
  print("Register service provider started running");
  try{
    String token = getX.read(constants.GETX_TOKEN);
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  print("Before postin the request");
  // mywidgets.displayToast(msg: "Before making the get request");
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.https(url,"/api/v1/offers"),
    headers: headers
  );
  // mywidgets.displayToast(msg: "after making the get request");
  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured $e";
  }
}

Future<dynamic> acceptOffers({required offer_id}) async {
  
  print("Register service provider started running");
  try{
    String token = getX.read(constants.GETX_TOKEN);
    String baseUrl = "https://base.usedara.com/api/v1/offer/$offer_id/accept";
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  print("Before postin the request");
  // mywidgets.displayToast(msg: "Before making the get request");
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.parse(baseUrl),
    headers: headers
  );
  // mywidgets.displayToast(msg: "after making the get request");
  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured $e";
  }
}

Future<dynamic> rejectOffers({required offer_id}) async {
  
  print("Register service provider started running");
  try{
    String token = getX.read(constants.GETX_TOKEN);
    String baseUrl = "https://base.usedara.com/api/v1/offer/$offer_id/reject";
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  

  print("Before postin the request");
  // mywidgets.displayToast(msg: "Before making the get request");
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.parse(baseUrl),
    headers: headers
  );
  // mywidgets.displayToast(msg: "after making the get request");
  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured $e";
  }
}

Future<dynamic> myProjects() async {
  
  print("Register service provider started running");
  try{
    String token = getX.read(constants.GETX_TOKEN);
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  print("Before postin the request");
  // mywidgets.displayToast(msg: "Before making the get request");
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.https(url,"/api/v1/projects"),
    headers: headers
  );
  // mywidgets.displayToast(msg: "after making the get request");
  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured $e";
  }
}


////////////////////// Clients projects 

Future<dynamic> allClientsProjects() async {
  
  print("Register service provider started running");
  try{
    String token = getX.read(constants.GETX_TOKEN);
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  print("Before postin the request");
  // mywidgets.displayToast(msg: "Before making the get request");
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.https(url,"/api/v1/customer/projects"),
    headers: headers
  );
  // mywidgets.displayToast(msg: "after making the get request");
  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured $e";
  }
}

Future<dynamic> completeProject({required projectId}) async {
  try {
    print("In the try method");
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "project_id": projectId,
    }; // Replace with your request data

    print("Before patching the request");

    http.Client client = http.Client();
    print("After defining the client object");

    final response = await client.patch(
      Uri.https(url, "/api/v1/project/done"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;
    print("Before returning the response");
    return jsonData;
  } on SocketException catch (e) {
    print("Socket Error Occurred : $e");
    return {"status": "Network Error"};
  } on Error catch (e) {
    print("Error Occurred : $e");
    return "Some error occurred";
  }
}



/////////////////////////// The Clients Apis request here >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Future<dynamic> registerClient({required email}) async {
  
  print("Register service provider started running");
  try{

  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> requestBody = {
    "email": email
  }; // Replace with your request data

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/customer/signup/otp"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}

Future<dynamic> verifyClient({required otp,required email}) async {
  
  print("Register service provider started running");
  try{

  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> requestBody = {
    "email": email,
    "otp": otp
  }; // Replace with your request data

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/customer/signup/otp/verify"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}

Future<dynamic> loginClient({required email, required password}) async {
  
  // print("Register service provider started running");
  try{

  // print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> requestBody = {
    "phone":email,
    "password":password
  }; // Replace with your request data

  // print("Before postin the request");
  
  http.Client client = http.Client();
  // print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/login"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  // print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    // print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    // print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    // print("Error Occured : $e");
    return "Some error occured";
  }
}

Future<dynamic> clientPersonalInfo({ required email ,required firstName,required lastName,required phone, required password}) async {
  
  // print("Register service provider started running");
  try{

  // print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> requestBody = {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "password":password,
    "phone":phone
  }; // Replace with your request data

  // print("Before postin the request");
  
  http.Client client = http.Client();
  // print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/customer/personal-information"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  // print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    // print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    // print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    // print("Error Occured : $e");
    return "Some error occured";
  }
}


Future<dynamic> userAddressInformation({File? imageFile, required country, required state, required area, required specificAddress, required user_id}) async {
  print("Register service provider started running");
  try {
    print("In the try method");

    String uri = 'https://base.usedara.com/api/v1/customer/address';
    final request = http.MultipartRequest('Post', Uri.parse(uri));

    request.fields['country'] = country;
    request.fields['state'] = state;
    request.fields['lga'] = area;
    request.fields['address'] = specificAddress;
    request.fields['user_id'] = user_id;

    if (imageFile != null) {
      final fileStream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final length = await imageFile.length();
      final multipartFile = http.MultipartFile('profile_image', fileStream, length,
          filename: path.basename(imageFile.path));
      request.files.add(multipartFile); // Add the file to the request
    }

    final response = await request.send();
    
    
      final responseString = await response.stream.bytesToString();
      final jsonData = json.decode(responseString) as Map;
      // print("Request completed successfully");
      return jsonData;
  } on SocketException catch (e) {
    return {"status":"Network Error"};
  } on Error catch (e) {
    print(e);
    return {"status":"Some error occurred"};
  }
}

Future<dynamic> resetPassword({ required newPassword, required confirmedPassword, required user_id}) async {
  
  print("Register service provider started running");
  try{

  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> requestBody = {
    "password": newPassword,
    "confirmed_password": confirmedPassword,
    "user_id": user_id
  }; // Replace with your request data

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/reset-password"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}


/////////////////////////////////////// The post api request 

Future<dynamic> createPost({
  List<XFile?>? imageFiles,
  required String token,
  required body,
}) async {
  print("Register service provider started running");
  try {
    print("In the try method");

    String uri = 'https://base.usedara.com/api/v1/status';
    final request = http.MultipartRequest('POST', Uri.parse(uri));

    // Set the authorization header with the provided token
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['body'] = body;

    if (imageFiles != null) {
      for (int i = 0; i < imageFiles.length; i++) {
        if (imageFiles[i] != null) {
          final fileStream =
              http.ByteStream(Stream.castFrom(imageFiles[i]!.openRead()));
          final length = await imageFiles[i]!.length();
          final multipartFile = http.MultipartFile(
            'media',
            fileStream,
            length,
            filename: path.basename(imageFiles[i]!.path),
          );
          request.files.add(multipartFile);
        }
      }
    }

    final response = await request.send();

    final responseString = await response.stream.bytesToString();
    final jsonData = json.decode(responseString) as Map;
    // print("Request completed successfully");
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    print(e);
    return {"status": "Some error occurred", "error":e};
  }
}

Future<dynamic> reloadUserObject() async {
  
  print("Register service provider started running");
  try{
    String token = getX.read(constants.GETX_TOKEN);
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.https(url,"/api/v1/reload"),
    headers: headers
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}


Future<dynamic> searchServiceProviders({required query}) async {
  
  print("Register service provider started running");
  try{
    String token = getX.read(constants.GETX_TOKEN);
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  print("Before postin the request");
  
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.https(url,"/api/v1/search"),
    headers: headers
  );

  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured";
  }
}


Future<dynamic> makeOfferToSP({required service_provider_id, required message, required price, required skill_needed}) async {
  
  // print("Register service provider started running");
  try{

  String token = getX.read(constants.GETX_TOKEN);
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  final Map<String, dynamic> requestBody = {
    "service_provider_id":service_provider_id,
    "message":message,
    "price":price,
    "skill_needed": skill_needed
  }; // Replace with your request data

  // print("Before postin the request");
  
  http.Client client = http.Client();
  // print("After defining the client object");
  final response = await client.post(
    Uri.https(url,"/api/v1/offer"),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  // print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    // print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    // print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    // print("Error Occured : $e");
    return "Some error occured";
  }
}


Future<dynamic> getClientOffers() async {
  
  print("Register service provider started running");
  try{
    String token = getX.read(constants.GETX_TOKEN);
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  print("Before postin the request");
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.https(url,"/api/v1/customer/offers"),
    headers: headers
  );
  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured $e";
  }
}


Future<dynamic> confirmProjectCompletion({required project_id}) async {
  
  String baseUrl = 'https://base.usedara.com/api/v1/customer/project/$project_id/confirmation';
  print("Register service provider started running");
  try{
    String token = getX.read(constants.GETX_TOKEN);
  print("In the try method");
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':'Bearer $token'
  };

  print("Before postin the request");
  http.Client client = http.Client();
  print("After defining the client object");
  final response = await client.get(
    Uri.parse(baseUrl),
    headers: headers
  );
  print("Before decoding the request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    print("Before returning the response");
    return jsonData;
  }
  on SocketException catch(e){
    print("Socket Error Occured : $e");
    return {"status":"Network Error"};
  }
  on Error catch (e){
    print("Error Occured : $e");
    return "Some error occured $e";
  }
}

Future<dynamic> getAgoraChannelToken({required channelName, required role}) async {

      print(">>>>>>>>>>>>>>>>In the getAgoraChannelToken Place...... Before making the http request to get token");

      http.Client client = http.Client();
      http.Response response = await client.post(
        
      Uri.https("gradeeasebackend.onrender.com", "/agora/generateAccessToken"),
      body: json.encode({
      "channel": channelName,
      "role": role,//subscriber, publisher
      }),

      
      headers: {
      "Content-Type": "application/json"
      },
      );

      print(">>>>>>>>>>>>>>>>Successfully made the Http request");
      dynamic decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      print(decodedResponse);
      return decodedResponse;
    }


