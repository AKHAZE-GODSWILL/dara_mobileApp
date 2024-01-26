import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dara_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dara_app/Provider/DataProvider.dart';

String mainUrl = "https://base.usedara.com/api/v1";

String url = 'base.usedara.com'; // Replace with your API endpoint

Future<dynamic> registerServiceProvider(
    {required countryCallCode, required phoneNumber}) async {
  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "phone": "${countryCallCode}${phoneNumber}"
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/signup/otp"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> saveBankAccount(
    {required account_number, required account_name, required bank}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final Map<String, dynamic> requestBody = {
      "account_number": account_number,
      "account_name": account_name,
      "bank": bank,
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/withdrawal/account"),
      headers: headers,
      body: jsonEncode(requestBody),
    );
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> loginServiceProvider(
    {required phoneNumber, required password}) async {
  print(phoneNumber);
  print(phoneNumber);
  print(phoneNumber);
  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "phone": phoneNumber,
      "password": password
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/login"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> verifyServiceProvider(
    {required otp, required phoneNumber}) async {
  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "phone": phoneNumber,
      "otp": otp
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/signup/otp/verify"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> userServiceInformation(
    {File? imageFile,
    required bio,
    required service,
    required skills,
    required experience,
    required user_id}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);

    String uri = 'https://base.usedara.com/api/v1/service-information';
    final request = http.MultipartRequest(
      'Post',
      Uri.parse(uri),
    );

    request.fields['user_id'] = user_id;
    request.fields['bio'] = bio;
    request.fields['service'] = service;
    request.fields['skills'] = skills;
    request.fields['experience'] = experience;
    request.headers["Authorization"] = 'Bearer $token';

    if (imageFile != null) {
      final fileStream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final length = await imageFile.length();
      final multipartFile = http.MultipartFile(
          'service_image', fileStream, length,
          filename: path.basename(imageFile.path));
      request.files.add(multipartFile); // Add the file to the request
    }

    final response = await request.send();

    final responseString = await response.stream.bytesToString();
    final jsonData = json.decode(responseString) as Map;
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return {"status": "Some error occurred"};
  }
}

Future<dynamic> sendUpdatedViews() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var views = getX.read("views");

    final Map<String, dynamic> requestBody = {
      "posts": views.toString().replaceAll("[", "").replaceAll("]", ""),
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/status/views"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);
    getX.remove("views");
    print(jsonData);

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> getNotifications() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/notifications"),
      headers: headers,
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);

    return jsonData["data"] == "0" ||
            jsonData["data"] == 0 ||
            jsonData["data"] == null
        ? []
        : jsonData["data"] == "0";
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> ServiceProviderMap() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/map"),
      headers: headers,
    );
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);
    return jsonData["data"];
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> ServiceProviderByCategory(category) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/categories/${category}"
          // ${category}"
          ),
      headers: headers,
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);

    return jsonData["data"];
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> fetchBanks() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/bank"),
      headers: headers,
    );
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);
    return jsonData["data"] ?? {};
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> fetchHistory() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/withdraw/history"),
      headers: headers,
    );
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);
    print(jsonData);
    return jsonData["data"] ?? [];
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> fetchReview(id) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/reviews/$id"),
      headers: headers,
    );
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);
    print(jsonData);
    return jsonData["data"] ?? [];
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> validateAccount(account_number, bank_code) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/account/resolve"),
      body: jsonEncode(
          {"account_number": account_number, "bank_code": bank_code}),
      headers: headers,
    );
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> submitWithdrawal(amount) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/withdraw"),
      body: jsonEncode({
        "amount": amount,
      }),
      headers: headers,
    );
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> fetchOfficialBanks() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/banks"),
      headers: headers,
    );
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);

    return jsonData["data"] ?? [];
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> getCategories() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/categories"),
      headers: headers,
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);

    return jsonData["data"];
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> getSkills() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/skills"),
      headers: headers,
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);

    return jsonData["data"];
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> getServices() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Client client = http.Client();
    final response = await client.get(
      Uri.https(url, "/api/v1/services"),
      headers: headers,
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);

    return jsonData["data"];
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> serviceProviderPersonalInfo(
    {required phoneNumber,
    required firstName,
    required lastName,
    required email,
    required password}) async {
  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "phone": phoneNumber,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/signup/personal-details"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> getOffers(context) async {
  DataProvider dataProvider = Provider.of(context, listen: false);

  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // mywidgets.displayToast(msg: "Before making the get request");
    http.Client client = http.Client();
    final response = await client.get(
        Uri.https(
            url,
            dataProvider.userType == "client"
                ? "/api/v1/customer/offers"
                : "/api/v1/offers"),
        headers: headers);
    // mywidgets.displayToast(msg: "after making the get request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured $e";
  }
}

Future<dynamic> acceptOffers({required offer_id}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    String baseUrl = "https://base.usedara.com/api/v1/offer/$offer_id/accept";
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // mywidgets.displayToast(msg: "Before making the get request");
    http.Client client = http.Client();
    final response = await client.get(Uri.parse(baseUrl), headers: headers);
    // mywidgets.displayToast(msg: "after making the get request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured $e";
  }
}

Future<dynamic> rejectOffers({required offer_id}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    String baseUrl = "https://base.usedara.com/api/v1/offer/$offer_id/reject";
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // mywidgets.displayToast(msg: "Before making the get request");
    http.Client client = http.Client();
    final response = await client.get(Uri.parse(baseUrl), headers: headers);
    // mywidgets.displayToast(msg: "after making the get request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured $e";
  }
}

Future<dynamic> myProjects(context) async {
  DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // mywidgets.displayToast(msg: "Before making the get request");
    http.Client client = http.Client();
    final response = await client.get(
        Uri.https(
            url,
            dataProvider.userType == "client"
                ? "/api/v1/customer/projects"
                : "/api/v1/projects"),
        headers: headers);
    // mywidgets.displayToast(msg: "after making the get request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured $e";
  }
}

////////////////////// Clients projects

Future<dynamic> allClientsProjects() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // mywidgets.displayToast(msg: "Before making the get request");
    http.Client client = http.Client();
    final response = await client
        .get(Uri.https(url, "/api/v1/customer/projects"), headers: headers);
    // mywidgets.displayToast(msg: "after making the get request");
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured $e";
  }
}

Future<dynamic> uploadReview({required service_provider, review}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final Map<String, dynamic> requestBody = {
      "service_provider": "$service_provider",
      "review": "$review"
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/review"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured $e";
  }
}

Future<dynamic> likePost({required status_id}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final Map<String, dynamic> requestBody = {
      "status_id": "$status_id",
    }; // Replace with your request data
    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/status/like"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured $e";
  }
}

Future<dynamic> unlikePost({required status_id}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final Map<String, dynamic> requestBody = {
      "status_id": "$status_id",
    }; // Replace with your request data
    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/status/unlike"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured $e";
  }
}

Future<dynamic> confirmProjectCompletion({required project_id}) async {
  String baseUrl =
      'https://base.usedara.com/api/v1/customer/project/$project_id/confirmation';
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Client client = http.Client();
    final response = await client.get(Uri.parse(baseUrl), headers: headers);
    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured $e";
  }
}

Future<dynamic> completeProject({required projectId}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    print({
      "token": "Bearer $token",
      "project_id": projectId,
      "end_note": "completed",
    });

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final Map<String, dynamic> requestBody = {
      "project_id": projectId,
      "end_note": "completed",
    }; // Replace with your request data

    http.Client client = http.Client();

    final response = await client.patch(
      Uri.https(url, "/api/v1/project/done"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final jsonData = json.decode(response.body);
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occurred";
  }
}

/////////////////////////// The Clients Apis request here >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Future<dynamic> registerClient({required email}) async {
  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "email": email
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/customer/signup/otp"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> verifyClient({required otp, required email}) async {
  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "email": email,
      "otp": otp
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/customer/signup/otp/verify"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> loginClient({required email, required password}) async {
  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "phone": email,
      "password": password
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/login"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> clientPersonalInfo(
    {required email,
    required firstName,
    required lastName,
    required phone,
    required password}) async {
  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "phone": phone
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/customer/personal-information"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> userAddressInformation(
    {File? imageFile,
    required country,
    required state,
    required area,
    required specificAddress,
    required user_id}) async {
  try {
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
      final multipartFile = http.MultipartFile(
          'profile_image', fileStream, length,
          filename: path.basename(imageFile.path));
      request.files.add(multipartFile); // Add the file to the request
    }

    final response = await request.send();

    final responseString = await response.stream.bytesToString();
    final jsonData = json.decode(responseString) as Map;
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return {"status": "Some error occurred"};
  }
}

Future<dynamic> resetPassword(
    {required newPassword,
    required confirmedPassword,
    required user_id}) async {
  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "password": newPassword,
      "confirmed_password": confirmedPassword,
      "user_id": user_id
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/reset-password"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

/////////////////////////////////////// The post api request

Future<dynamic> createPost({
  List<XFile?>? imageFiles,
  required String token,
  required body,
}) async {
  try {
    String uri = '${mainUrl}/status';
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
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return {"status": "Some error occurred", "error": e};
  }
}

Future<dynamic> updatePersonalInfo(
    {File? imageFile,
    required first_name,
    required last_name,
    required phone,
    required email,
    required bio}) async {
  try {
    String uri = 'https://base.usedara.com/api/v1/profile/update';
    final request = http.MultipartRequest('Post', Uri.parse(uri));
    request.fields['first_name'] = first_name;
    request.fields['last_name'] = last_name;
    request.fields['phone'] = phone;
    request.fields['email'] = email;
    request.fields['bio'] = bio;
    if (imageFile != null) {
      final fileStream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final length = await imageFile.length();
      final multipartFile = http.MultipartFile(
          'profile_image', fileStream, length,
          filename: path.basename(imageFile.path));
      request.files.add(multipartFile); // Add the file to the request
    }
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final jsonData = json.decode(responseString);
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return {"status": "Some error occurred"};
  }
}

Future<dynamic> updateAddressInfo(
    {File? imageFile,
    required country,
    required state,
    required lga,
    required address,
    required user_id,
    required phone,
    d}) async {
  try {
    String uri = 'https://base.usedara.com/api/v1/service-information';
    final request = http.MultipartRequest('Post', Uri.parse(uri));
    request.fields['country'] = country;
    request.fields['state'] = state;
    request.fields['lga'] = lga;
    request.fields['address'] = address;
    request.fields['user_id'] = user_id;
    request.fields['phone'] = phone;
    if (imageFile != null) {
      final fileStream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final length = await imageFile.length();
      final multipartFile = http.MultipartFile(
          'service_image', fileStream, length,
          filename: path.basename(imageFile.path));
      request.files.add(multipartFile); // Add the file to the request
    }
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final jsonData = json.decode(responseString);
    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return {"status": "Some error occurred"};
  }
}

Future<dynamic> reloadUserObject() async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Client client = http.Client();
    final response =
        await client.get(Uri.https(url, "/api/v1/reload"), headers: headers);

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> searchServiceProviders({required query}) async {
  print(query);
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Client client = http.Client();
    final response =
        await client.get(Uri.https(url, "/api/v1/search"), headers: headers);

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> makeOfferToSP(
    {required service_provider_id,
    required message,
    required skill_needed}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final Map<String, dynamic> requestBody = {
      "service_provider_id": service_provider_id,
      "message": message,
      "price": 0,
      "skill_needed": skill_needed
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/offer"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> setProjectAmount({
  required amount,
  required project_id,
}) async {
  try {
    print(project_id);
    print(amount);
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final Map<String, dynamic> requestBody = {
      "amount": amount,
      "project_id": project_id,
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/project/amount"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response);

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> sendLocation({
  required latitude,
  required longitude,
}) async {
  try {
    String token = getX.read(constants.GETX_TOKEN);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final Map<String, dynamic> requestBody = {
      "latitude": latitude,
      "longitude": longitude
    }; // Replace with your request data

    http.Client client = http.Client();
    final response = await client.post(
      Uri.https(url, "/api/v1/location"),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final utf8Response = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(utf8Response) as Map;

    return jsonData;
  } on SocketException catch (e) {
    return {"status": "Network Error"};
  } on Error catch (e) {
    return "Some error occured";
  }
}

Future<dynamic> getAgoraChannelToken(
    {required channelName, required role}) async {
  Future<dynamic> getClientOffers() async {
    try {
      String token = getX.read(constants.GETX_TOKEN);
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      http.Client client = http.Client();
      final response = await client
          .get(Uri.https(url, "/api/v1/customer/offers"), headers: headers);
      final utf8Response = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(utf8Response) as Map;

      return jsonData;
    } on SocketException catch (e) {
      return {"status": "Network Error"};
    } on Error catch (e) {
      return "Some error occured $e";
    }
  }

  Future<dynamic> getAgoraChannelToken(
      {required channelName, required role}) async {
    print(
        ">>>>>>>>>>>>>>>>In the getAgoraChannelToken Place...... Before making the http request to get token");

    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https("gradeeasebackend.onrender.com", "/agora/generateAccessToken"),
      body: json.encode({
        "channel": channelName,
        "role": role, //subscriber, publisher
      }),
      headers: {"Content-Type": "application/json"},
    );

    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    return decodedResponse;
  }
}
