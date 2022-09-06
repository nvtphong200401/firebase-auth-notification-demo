import 'dart:convert';

import 'package:demo_firebase/domain/controllers/noti_controller.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';


class Api {
  static const url = 'https://fcm.googleapis.com/v1/projects/fir-demo-8bb64/messages:send';
  Future<Map<String, dynamic>> get(String endPoint) async{
    try{
      final response = await http.get(Uri.parse(url + endPoint));
      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    }
    catch(err){
      print("err");
      throw Exception('internal Error');
    }
  }
  Future<Map<String, dynamic>> post(String endPoint, dynamic body) async {
    try{
      print('token ${NotiController.token}');
      final response = await http.post(Uri.parse(url + endPoint), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${NotiController.token}',
      });
      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    }
    on Exception {
      throw Exception("invalid");
    }
  }
  Map<String, dynamic> classifyResponse(response){
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    switch(response.statusCode){
      case 200:
      case 201:
        return responseData;
      case 400:
      case 401:
        throw Exception(responseData["status_message"].toString());
      case 500:
      default:
        throw Exception('Error occured while communication with status code: ${response.statusCode}');
    }
  }
}