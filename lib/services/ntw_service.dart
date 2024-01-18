import 'dart:convert';

import 'package:http/http.dart';

class NetworkService{

  static const String baseUrl = "https://60b5b08ca7d9970017c43b8b.mockapi.io/personDetail";

  static const String apiGetAllData = "/personDetail";
  static const String apiDeleteData = "/personDetail/";


  static Future<String> POST(String api, Map<String, dynamic> body) async{
    Uri url = Uri.https(baseUrl, api);

    Response response = await post(url,  body: jsonEncode(body));
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.body;
    } else {
      return "Error!! statusCode of ${response.statusCode}";
    }
  }

  static Future<String> GET(String api)async{
    Uri url = Uri.https(baseUrl, api);
    Response response = await get(url);
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.body;
    }else{
      return "Error statusCode of ${response.statusCode}";
    }
  }

  static Future<String> DELETE(String api, int id)async{
    Uri url = Uri.https(baseUrl, api+id.toString());
    Response response = await delete(url);
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.statusCode.toString();
    }else{
      return "Error statusCode of ${response.statusCode}";
    }
  }
}